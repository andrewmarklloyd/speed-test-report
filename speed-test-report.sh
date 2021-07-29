#!/bin/bash

if ! command -v speedtest &> /dev/null; then
  curl -s -O https://install.speedtest.net/app/cli/ookla-speedtest-1.0.0-arm-linux.tgz
  tar zxf ookla-speedtest-1.0.0-arm-linux.tgz
  sudo mv speedtest /usr/local/bin/speedtest
  rm speedtest.*
  rm ookla-speedtest-1.0.0-arm-linux.tgz
fi

if ! command -v jq &> /dev/null; then
  sudo apt-get update
  sudo apt-get install jq -y
fi

if [[ -z ${URL} || -z ${TOKEN} ]]; then
  echo "URL and TOKEN environment variables must be set"
  exit 1
fi

speed_test_report() {
  result=$(speedtest --format=json-pretty --progress=no --accept-license --accept-gdp)
  down=$(echo "${result}" | jq -r '.download.bytes')
  up=$(echo "${result}" | jq -r '.upload.bytes')
  curl -s -H 'Content-Type: application/json' -d "{\"timestamp\":\"$(date +%s)\", \"download\":\"${down}\", \"upload\":\"${up}\", \"token\":\"${TOKEN}\"}" -L "${URL}"
}

speed_test_report
