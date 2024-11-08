#!/bin/sh

set -e

CURRENT_BRANCH=$(git rev-parse HEAD)
STAGING_BRANCH=staging

git branch -D $STAGING_BRANCH >/dev/null 2>&1 || true

git checkout -b $STAGING_BRANCH
git reset --hard $(git show $CURRENT_BRANCH:HEAD)

for patch in $(git show $CURRENT_BRANCH:patches | grep '[.]patch$'); do
	git show $CURRENT_BRANCH:patches/$patch | git am -
done
