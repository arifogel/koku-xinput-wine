#!/usr/bin/env bash

set -euo pipefail

function die() {
  echo "$@"
  exit 1
}

docker info >& /dev/null || die "Docker daemon is not running"

docker build . -t koku-xinput-wine:1.2.2
docker run koku-xinput-wine:1.2.2 cat koku-xinput-wine.so > koku-xinput-wine.so

