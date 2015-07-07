#!/bin/bash

BASE_DIR="$(dirname "$(dirname "${BASH_SOURCE[0]}")")"
if [[ -e "${BASE_DIR}/tmp/pids/unicorn.pid" ]]; then
  echo restarting....
  kill `cat "${BASE_DIR}/tmp/pids/unicorn.pid"`
  sleep 5
fi
bundle exec unicorn_rails -c "${BASE_DIR}/config/unicorn.rb" -D -E production
