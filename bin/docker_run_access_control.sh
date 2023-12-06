[[ "$TRACE" ]] && set -x
#!/usr/bin/env sh
set -eu -o pipefail

#docker build --tag test-acm -f ./Dockerfile.terraform .
#terraform plan -out ./access_control.tfout -var-file env/terraform.tfvars

docker run --rm -it \
	-v $(pwd):/mnt \
	-w /mnt/tf/applications/access_control \
	test-acm ./bin/terraform_acm.sh
