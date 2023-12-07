#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail

docker run --rm -i -t \
	gcloud:latest "$@"
