#!/usr/bin/env python3

import argparse
import glob
import hashlib
import os.path
import re
import shutil
from pathlib import Path
from pathlib import PureWindowsPath
from subprocess import Popen, PIPE, call
from typing import Dict, Optional, List


class File(object):
    def __init__(self, name, hash, split, skip):
        self.name = name
        self.hash = hash
        self.split = split
        self.skip = skip


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
                line = line.strip()
                skip = False
                if line.startswith("#"):
                    skip = True
                    line = line.lstrip("# ")
                items = line.split(',')
                name = items[0].strip()
                files[name] = File(name, items[1].strip(), int(items[2].strip()), skip)
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
    for name in glob.glob(pathname, recursive=True):
        name = PureWindowsPath(name).as_posix()
        if name.endswith('_backfill.sql'):
            continue
        files[name] = File(name, sha256(name), 0, False)
    return files


def check_file_list(pathname: str, files: Dict[str, File]) -> (List[File], List[File], List[File]):
    new_files = list()
    modified_files = list()
    removed_files = list()
    for file in files.values():
        if not os.path.isfile(file.name):
            removed_files.append(file)
    for name in glob.glob(pathname, recursive=True):
        name = PureWindowsPath(name).as_posix()
        if name.endswith('_backfill.sql'):
            continue
        file = files.get(name, None)
        if not file:
            new_files.append(File(name, sha256(name), 0, False))
        else:
            if file.skip:
                continue
            hash = sha256(name)
            if hash != file.hash:
                modified_files.append(File(name, hash, 0, False))
    return new_files, modified_files, removed_files


def apply_patch(filename: str) -> int:
    if os.path.isfile(filename):
        return call(['git', 'apply', '--reject', filename])
    else:
        return 0


def revert_patch(path: str) -> int:
    return call(['git', 'checkout', '-f', path])


def prepare(filename: str, env: Dict[str, str]) -> int:
    if os.path.isfile(filename):
        return call(['psql', '-v', 'ON_ERROR_STOP=1', '-f', filename], env=env)
    else:
        return 0


def max_block_number(match) -> str:
    arg = match.group(3)
    if arg is None:
        arg = "(" + match.group(2) + ")"
    return "SELECT max_block_number_" + ("le" if match.group(1) == "<=" else "lt") + arg


def filter_max_block_expr(s: str) -> str:
    return re.sub(r"SELECT\s+MAX\s*\(\s*number\s*\)\s+FROM\s+ethereum\.blocks\s+WHERE\s+time\s*(<|<=)\s*(?:('.+')|(\(.+\)))",
                  max_block_number, s, flags=re.IGNORECASE)


def fix_bytea(match):
    arg = match.group(1)
    if arg is None:
        return "\\\\x" + match.group(2)
    else:
        return arg + "::BYTEA"


def filter_bytea_literals(s: str) -> str:
    return re.sub(r"(?:('\\x[\da-f]{2,}')(?! *:: *BYTEA))|(?:\\\\([\da-f]{2,}))", fix_bytea, s, flags=re.IGNORECASE)


def apply_schema(files: List[File], env: Dict[str, str], backfill: bool = False):
    for file in files:
        if file.skip:
            print("Skipping", file.name)
            continue
        print(file.name)
        with Popen(['psql', '-v', 'ON_ERROR_STOP=1'], stdin=PIPE, stdout=PIPE, stderr=PIPE, text=True, restore_signals=True, env=env) as psql:
            with open(file.name, 'r') as f:
                for i, line in enumerate(f.readlines(), start=1):
                    if backfill or file.split <= 0 or i < file.split:
                        line = filter_bytea_literals(line)
                        if backfill:
                            line = filter_max_block_expr(line)
                        print(line, file=psql.stdin, flush=True, end='')
                        if not backfill and line.startswith("$function$"):
                            break
            psql.stdin.close()
            for line in psql.stderr.readlines():
                print(line, end='')
            for line in psql.stdout.readlines():
                print(line, end='')


def make_backfill_scripts(filename: str, files: List[File]):
    with open(filename, 'w') as fl:
        for file in files:
            if file.split > 0:
                path = Path(file.name)
                name = path.with_stem(path.stem + '_backfill')
                with open(file.name, 'r') as f, open(name, 'w') as bf:
                    print(name, file=fl)
                    for i, line in enumerate(f.readlines(), start=1):
                        if i >= file.split:
                            print(line, file=bf, end='')


def apply_backfill_scripts(filename: str, env: Dict[str, str]):
    with open(filename, 'w') as f:
        for fn in f.readlines():
            fn = fn.strip()
            if fn.startswith("#"):
                print("Skipping", fn)
                continue
            print(fn)
            with Popen(['psql', '-v', 'ON_ERROR_STOP=1'], stdin=PIPE, stdout=PIPE, stderr=PIPE, text=True,
                       restore_signals=True, env=env) as psql:
                with open(fn, 'r') as f:
                    for i, line in enumerate(f.readlines(), start=1):
                        print(filter_max_block_expr(line), file=psql.stdin, flush=True, end='')
                psql.stdin.close()
                for line in psql.stderr.readlines():
                    print(line, end='')
                for line in psql.stdout.readlines():
                    print(line, end='')


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


def main(args) -> int:
    if args.revert_patch:
        revert_patch('ethereum')
        return 0

    if args.apply_patch:
        return apply_patch('patch.patch')

    if args.update_list:
        files = load_file_list('scripts.csv')
        new_files = init_file_list('ethereum/**/*.sql')
        new_files_, modified_files, removed_files = update_file_list('scripts.csv', files, new_files)
        print_updated_files(new_files_, modified_files, removed_files)
        if args.make_backfill:
            make_backfill_scripts('script-list.txt', files.values())
        return 0

    files = load_file_list('scripts.csv')
    new_files, modified_files, removed_files = check_file_list('ethereum/**/*.sql', files)
    if not args.skip_patch:
        if print_updated_files(new_files, modified_files, removed_files):
            print('Have to fix updates')
            return -1

    if len(files) == 0:
        print('No scripts to apply')
        return -1

    if not args.skip_patch:
        if apply_patch('patch.patch') != 0:
            return -1

    env = get_env()

    if args.prepare:
        if prepare('prepare.sql', env) != 0:
            return -1

    if args.apply_backfills:
        apply_backfill_scripts('script-list.txt', env)
    else:
        apply_schema(files.values(), env, args.use_backfills)
    return 0


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Script to apply Dune abstractions scripts in `ethereum` dir')
    parser.add_argument('-u', '--update-list', dest='update_list', action='store_true', help='update script list `scripts.csv`', default=False)
    parser.add_argument('-a', '--apply-backfills', dest='apply_backfills', action='store_true', help='apply backfill query files', default=False)
    parser.add_argument('-b', '--use-backfills', dest='use_backfills', action='store_true', help='use backfill queries if exists', default=False)
    parser.add_argument('-s', '--skip-patch', dest='skip_patch', action='store_true', help='skip patch applying', default=False)
    parser.add_argument('-r', '--revert-patch', dest='revert_patch', action='store_true', help='revert patch modifications', default=False)
    parser.add_argument('-p', '--prepare', dest='prepare', action='store_true', help='use prepare.sql', default=False)
    parser.add_argument('-m', '--make_backfill', dest='make_backfill', action='store_true', help='make backfill scripts', default=False)
    parser.add_argument('-c', '--apply-patch', dest='apply_patch', action='store_true', help='only apply patch', default=False)
    args = parser.parse_args()
    print(args)
    return_code = main(args)
    if return_code != 0:
        exit(return_code)
