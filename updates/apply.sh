#!/bin/bash

source ".env"

capture_error()
{
  MESSAGE=$1
  EVENT_ID=`uuidgen`
  EVENT_TIMESTAMP=`date --utc +"%Y-%m-%dT%H:%M:%S"`
  SENTRY_TIMESTAMP=`date +%s`

  curl -s -kL --data "{
    \"event_id\": \"$EVENT_ID\",
    \"timestamp\": \"$EVENT_TIMESTAMP\",
    \"message\": \"$MESSAGE\",
    \"tags\": {
        \"server_name\": \"`hostname`\",
        \"path\": \"`pwd`\"
    },
    \"exception\": [{
        \"type\": \"ScriptError\",
        \"value\": \"$MESSAGE\"
    }]
  }" \
  -H "Content-Type: application/json" \
  -H "X-Sentry-Auth: Sentry sentry_version=7, sentry_client=apply.sh/1.0, sentry_key=$SENTRY_KEY" \
  "https://$SENTRY_HOST/api/$SENTRY_PROJECTID/store/"
}

git init && \
git remote add origin https://github.com/duneanalytics/abstractions && \
git fetch && \
git checkout -t origin/master && \
./apply.py
if [ $? -eq 0 ]
then
  echo "Dune schema updated"
else
  capture_error "Dune schema update error"
  exit -1
fi
