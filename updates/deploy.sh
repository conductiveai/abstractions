#!/bin/bash

set -Eeuo pipefail

DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

source "${DIR}/.env"

REPOSITORY=($(gcloud artifacts repositories list --filter="labels.goog-composer-environment=${COMPOSER}" --format="value(name,labels.goog-composer-location)" --project=${PROJECT}))

LOCATION=${REPOSITORY[1]}
HOST="${LOCATION}-docker.pkg.dev"
IMAGE="${HOST}/${PROJECT}/${REPOSITORY[0]}/abstractions-updater"

gcloud auth configure-docker ${HOST}

docker image build --no-cache --tag ${IMAGE}:${VERSION} --file "${DIR}/Dockerfile" "${DIR}"
docker push --all-tags ${IMAGE}
docker image remove --force ${IMAGE}:${VERSION}
docker image prune -f

docker container run --rm --env IMAGE="${IMAGE}" --env-file "${DIR}/.env" -v "${DIR}":/work -t ccll/alpine-envsubst sh -c "envsubst < /work/abstractions_updater.py > /work/abstractions_updater_out.py"

DAGS=$(gcloud composer environments describe ${COMPOSER} --project=${PROJECT} --location=${LOCATION} --format="get(config.dagGcsPrefix)")

gsutil mv "${DIR}/abstractions_updater_out.py" "${DAGS}/abstractions_updater.py"
gsutil cp -r "${DIR}/sql/" "${DAGS}/"
