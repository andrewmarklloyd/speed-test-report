#!/bin/bash


# Download speedtest binary for arm
# https://install.speedtest.net/app/cli/ookla-speedtest-1.0.0-arm-linux.tgz

if [[ -z ${URL} || -z ${TOKEN} ]]; then
  echo "URL and TOKEN environment variables must be set"
  exit 1
fi

speed_test_report() {
  result=$(speedtest)
  down=$(echo "${result}" | grep Download | awk '{print $3}')
  up=$(echo "${result}" | grep Upload | awk '{print $3}')
  curl -s -H 'Content-Type: application/json' -d "{\"timestamp\":\"$(date +%s)\", \"download\":\"${down}\", \"upload\":\"${up}\", \"token\":\"${TOKEN}\"}" -L "${URL}"
}

speed_test_report
