#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail

docker run --rm -i -t \
	-v "$(pwd):/app" \
	-w /app \
	--entrypoint sh \
	hashicorp/terraform:1.4
