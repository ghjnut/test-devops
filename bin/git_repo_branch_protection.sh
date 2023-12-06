#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
set -eu -o pipefail

name="$GH_REPO_NAME"
owner="$GH_REPO_OWNER"
repositoryId="$(gh api graphql -f query='{repository(owner:"'$owner'",name:"'$name'"){id}}' -q .data.repository.id)"

# if len(repositoryId) > 1, error

# applies requiredReviews=1 to main/master
gh api graphql -f query='
mutation($repositoryId:ID!,$branch:String!,$requiredReviews:Int!) {
  createBranchProtectionRule(input: {
    repositoryId: $repositoryId
    pattern: $branch
    requiresApprovingReviews: true
    requiredApprovingReviewCount: $requiredReviews
  }) { clientMutationId }
}' -f repositoryId="$repositoryId" -f branch="[main,master]*" -F requiredReviews=1
