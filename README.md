# Code test

1. Git(hub)

Build (base docker container with git + github cli)

	docker build --tag test-github -f ./Dockerfile.github .

Generate `GITHUB_TOKEN`
**WARNING** this creates a 'GitHub CLI' OAuth application with high-level perms.
Accessible at (https://github.com/settings/applications)
Ideally a more constrained access token should be used via (https://github.com/settings/tokens?type=beta)

	$./bin/docker_run_git.sh

	$ gh auth status
	You are not logged into any GitHub hosts. Run gh auth login to authenticate.

	$ gh auth login
	? What account do you want to log into? GitHub.com
	? What is your preferred protocol for Git operations? SSH
	? Generate a new SSH key to add to your GitHub account? No
	? How would you like to authenticate GitHub CLI? Login with a web browser

	! First copy your one-time code: 00FF-00FF
	Press Enter to open github.com in your browser...
	✓ Authentication complete.
	- gh config set -h github.com git_protocol ssh
	✓ Configured git protocol
	✓ Logged in as ghjnut

	$ gh auth token
	gho_<REDACTED>

	# add GITHUB_TOKEN to .env file
	$ printf "GITHUB_TOKEN=\n%s\n" "$(gh auth token)" >>.env

Execute (GitHub interactions currently disabled)

	$ ./bin/docker_run_git.sh
	$ ./bin/git_repo_setup.sh


2. Access Control Management (TF)
requires `tf/applications/*/terraform-private-key.json` for provisioning permissions (see initial auth below)

See (./tf/applications/access_control/README.md)

		$ ./bin/terraform.sh
		$ cd tf/applications/access_control
		$ terraform init && terraform plan -var-file env/dev.tfvars

3. CI/CD (TF)
requires `tf/applications/*/terraform-private-key.json` for provisioning permissions (see initial auth below)

		$ ./bin/terraform.sh
		$ cd tf/applications/cicd
		$ terraform init && terraform plan -var-file env/dev.tfvars

4. Infra as Code (TF)
requires `tf/applications/*/terraform-private-key.json` for provisioning permissions (see initial auth below)

		$ ./bin/terraform.sh
		$ cd tf/applications/iac
		$ terraform init && terraform plan -var-file env/dev.tfvars


### GCP TF initial auth

Create

	$ gcloud iam service-accounts create terraform

[enable IAM API](https://console.cloud.google.com/apis/enableflow?apiid=iam.googleapis.com)

Set default project

	$ gcloud config set project codetest-406510
	Updated property [core/project].

	create token key
	$ gcloud iam service-accounts keys create ./terraform-private-key.json --iam-account=terraform@codetest-406510.iam.gserviceaccount.com
	created key [96f9d98685e8404d9beb4038311e0378bf37aefe] of type [json] as [./terraform-private-key.json] for [terraform@codetest-406510.iam.gserviceaccount.com]

bind service account to role

	[ghjnut@derek frontera]$ gcloud projects add-iam-policy-binding codetest-406510 --member="serviceAccount:terraform@codetest-406510.iam.gserviceaccount.com" --role="roles/owner"
	Updated IAM policy for project [codetest-406510].
	bindings:
	- members:
	  - serviceAccount:terraform@codetest-406510.iam.gserviceaccount.com
	  - user:<REDACTED>
	  role: roles/owner
	etag: BwYLQ7RAVuE=
	version: 1

[enable cloud resource manager api](https://console.cloud.google.com/apis/library/cloudresourcemanager.googleapis.com)
