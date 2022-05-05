#!/usr/bin/env python3

import getopt
import glob
import hashlib
import os.path
import sys
import shutil
from pathlib import Path
from subprocess import Popen, PIPE, call
from typing import Dict, Optional, List


class File(object):
    def __init__(self, name, hash, split):
        self.name = name
        self.hash = hash
        self.split = split


def get_env(path: Optional[str] = None) -> Dict[str, str]:
    env = dict(os.environ)
    if not path:
        path = '.env'
    with open(path, 'r') as f:
        for line in f.readlines():
            if not line.startswith('#'):
                items = line.split('=')
                env[items[0].strip(' ')] = items[1].strip('\n\t" ')
    return env


def sha256(filename: str) -> str:
    h = hashlib.sha256()
    with open(filename, "rb") as f:
        for chunk in iter(lambda: f.read(4096), b""):
            h.update(chunk)
    return h.hexdigest()


def load_file_list(filename: str) -> Dict[str, File]:
    files = dict()
    if os.path.isfile('scripts.csv'):
        with open(filename, 'r') as f:
            for line in f.readlines():
                items = line.split(',')
                name = items[0]
                files[name] = File(name, items[1], int(items[2]))
    return files


def update_file_list(filename: str, files: Dict[str, File], new_files: Dict[str, File]) -> (List[File], List[File], List[File]):
    new_files_ = list()
    modified_files = list()
    removed_files = list()
    for file in files.values():
        if not os.path.isfile(file.name):
            removed_files.append(file)
    for file in removed_files:
        del files[file.name]
    for new_file in new_files.values():
        file = files.get(new_file.name, None)
        if not file:
            files[new_file.name] = new_file
            new_files_.append(new_file)
        else:
            if new_file.hash != file.hash:
                file.hash = new_file.hash
                modified_files.append(file)
    if os.path.isfile(filename):
        shutil.move(filename, filename + '.bak')
    with open(filename, 'w') as f:
        for file in files.values():
            print(file.name, file.hash, str(file.split), sep=',', file=f)
    return new_files_, modified_files, removed_files


def init_file_list(pathname: str) -> Dict[str, File]:
    files = dict()
    insert = dict()
    for name in glob.glob(pathname, recursive=True):
        if name.endswith('_backfill.sql'):
            continue
        file = File(name, sha256(name), 0)
        if Path(name).name.startswith("insert"):
            insert[name] = file
        else:
            files[name] = file
    files.update(insert)
    return files


def check_file_list(pathname: str, files: Dict[str, File]) -> (List[File], List[File], List[File]):
    new_files = list()
    modified_files = list()
    removed_files = list()
    for file in files.values():
        if not os.path.isfile(file.name):
            removed_files.append(file)
    for name in glob.glob(pathname, recursive=True):
        if name.endswith('_backfill.sql'):
            continue
        file = files.get(name, None)
        if not file:
            new_files.append(File(name, sha256(name), 0))
        else:
            hash = sha256(name)
            if hash != file.hash:
                modified_files.append(File(name, hash, 0))
    return new_files, modified_files, removed_files


def apply_patch(filename: str) -> int:
    if os.path.isfile(filename):
        return call(['git', 'apply', filename])
    else:
        return 0


def prepare(filename: str, env: Dict[str, str]) -> int:
    if os.path.isfile(filename):
        return call(['psql', '-v', 'ON_ERROR_STOP=1', '-f', filename], env=env)
    else:
        return 0


def apply_schema(files: List[File], env: Dict[str, str], backfill: bool = False):
    for file in files:
        with Popen(['psql', '-v', 'ON_ERROR_STOP=1'], stdin=PIPE, stdout=PIPE, stderr=PIPE, text=True, restore_signals=True, env=env) as psql:
            print(file.name)
            with open(file.name, 'r') as f:
                for i, line in enumerate(f.readlines(), start=1):
                    if backfill or (file.split <= 0 or i < file.split):
                        print(line, file=psql.stdin, flush=True, end='')
            psql.stdin.close()
            for line in psql.stderr.readlines():
                print(line, end='')
            for line in psql.stdout.readlines():
                print(line, end='')


def make_backfill_scripts(files: List[File]):
    with open('script-list.txt', 'w') as fl:
        for file in files:
            if file.split > 0:
                path = Path(file.name)
                name = path.with_stem(path.stem + '_backfill')
                with open(file.name, 'r') as f, open(name, 'w') as bf:
                    print(name, file=fl)
                    for i, line in enumerate(f.readlines(), start=1):
                        if i >= file.split:
                            print(line, file=bf, end='')


def print_updated_files(new_files: List[File], modified_files: List[File], removed_files: List[File]) -> bool:
    has_updates = False
    if len(new_files) > 0:
        print("-- New files --")
        for f in new_files:
            print(f.name, f.hash, f.split, sep=',')
        has_updates = True
    if len(modified_files) > 0:
        print("-- Modified files --")
        for f in modified_files:
            print(f.name, f.hash, f.split, sep=',')
        has_updates = True
    if len(removed_files) > 0:
        print("-- Removed files --")
        for f in removed_files:
            print(f.name, f.hash, f.split, sep=',')
        has_updates = True
    return has_updates


def main(argv) -> int:
    opts, args = getopt.getopt(argv, "ub")
    update = False
    backfill = False
    for opt, arg in opts:
        if opt == '-u':
            update = True
        elif opt == '-b':
            backfill = True

    if update:
        files = load_file_list('scripts.csv')
        new_files = init_file_list('ethereum/**/*.sql')
        new_files_, modified_files, removed_files = update_file_list('scripts.csv', files, new_files)
        print_updated_files(new_files_, modified_files, removed_files)
        make_backfill_scripts(files.values())
        return 0

    files = load_file_list('scripts.csv')
    new_files, modified_files, removed_files = check_file_list('ethereum/**/*.sql', files)
    if print_updated_files(new_files, modified_files, removed_files):
        print('Have to fix updates')
        return -1

    if len(files) == 0:
        print('No scripts to apply')
        return -1

    env = get_env()

    if apply_patch('patch.patch') != 0:
        return -1

    if prepare('prepare.sql', env) != 0:
        return -1

    apply_schema(files.values(), env, backfill)
    return 0


if __name__ == "__main__":
    return_code = main(sys.argv[1:])
    if return_code != 0:
        exit(return_code)
