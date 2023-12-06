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
