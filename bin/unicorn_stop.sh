#!/bin/bash

BASE_DIR="$(dirname "$(dirname "${BASH_SOURCE[0]}")")"
echo stoping....
if [[ -e "${BASE_DIR}/tmp/pids/unicorn.pid" ]]; then
  kill `cat "${BASE_DIR}/tmp/pids/unicorn.pid"`
fi
