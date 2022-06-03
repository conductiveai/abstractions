#!/bin/bash

set -Eeuo pipefail

DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

source "${DIR}/.env"

DAGS=$(gcloud composer environments describe ${COMPOSER} --project=${PROJECT} --location=${LOCATION} --format="get(config.dagGcsPrefix)")

gsutil cp "${DIR}/label_updater.py" "${DAGS}/label_updater.py"
gsutil cp "${DIR}/*.sql" "${DAGS}/sql/"
