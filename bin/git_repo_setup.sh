#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail

GITHUB_TOKEN="${GITHUB_TOKEN:-test_github_token}"

GITHUB_USER_EMAIL="${GITHUB_USER_EMAIL:-test@example.com}"
GITHUB_USER_NAME="${GITHUB_USER_NAME:-test}"

# TODO: ansibleize

# config
# TODO: can be testing placeholders?
git config --global user.email "${GITHUB_USER_EMAIL}"
git config --global user.name "${GITHUB_USER_NAME}"

# TODO: --private
# what perms required?
if false; then gh repo create devops --private; fi

git init --initial-branch main /tmp/repo1

# create remote (e.g. github)
#git remote add origin git@github.com:${GITHUB_REPO}.git
cd /tmp/repo1

# to duplicate repo, need >1 commit
echo "foo" >README.md
git add README.md
git commit -m "add foo"

cp -R /tmp/repo1 /tmp/repo2

git remote add repo2 /tmp/repo2/.git

# create/push default branches
git checkout -b testing
git push repo2 testing

git checkout -b develop
git push repo2 develop

# TODO: branch protections
# see ./git_repo_branch_protection.sh

git checkout -b feature-init

# test push

echo "bar" >>README.md
git add README.md
git commit -m "add bar"

git push repo2 feature-init

cd /tmp/repo2
git branch
