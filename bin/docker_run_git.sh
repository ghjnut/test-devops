#!/usr/bin/env sh
[[ "$TRACE" ]] && set -x
set -eu -o pipefail

docker run --rm -it \
	--env-file .env \
	-v $(pwd):/app \
	-w /app \
	test-github
