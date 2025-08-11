#!/usr/bin/env bash
set -euo pipefail

# Usage: ./script.sh [ENV_FILE]
ENV_FILE="${1:-.env}"

if [[ ! -f "$ENV_FILE" ]]; then
  echo "Env file not found: $ENV_FILE" >&2
  exit 1
fi

set -a
. "$ENV_FILE"
set +a

cleanup() {
  echo "Running cleanup: checking for container 'r8125'"
  if podman container exists r8125; then
    podman rm -f r8125
    echo "Removed container 'r8125'"
  else
    echo "Container 'r8125' does not exist, skipping removal"
  fi
}
trap cleanup ERR

podman build -t build_r8125 --build-arg ENV_FILE=${ENV_FILE} .
podman create --name r8125 build_r8125
podman cp r8125:/lib/modules/${KERNEL_VERSION}/updates/dkms/r8125.ko output/

cleanup
