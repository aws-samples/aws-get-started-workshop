#!/bin/bash

# Populate environment variables with Git repo values so that we can support
# building feature branches and PRs.

export CUSTOM_CODEBUILD_GIT_BRANCH="$(git symbolic-ref HEAD --short 2>/dev/null)"

if [ "$CUSTOM_CODEBUILD_GIT_BRANCH" = "" ] ; then
  CUSTOM_CODEBUILD_GIT_BRANCH="$(git branch -a --contains HEAD | sed -n 2p | awk '{ printf $1 }')";
  export CUSTOM_CODEBUILD_GIT_BRANCH=${CUSTOM_CODEBUILD_GIT_BRANCH#remotes/origin/};
fi
export CUSTOM_CODEBUILD_GIT_BRANCH_CLEAN="$(echo $CUSTOM_CODEBUILD_GIT_BRANCH | tr '/' '.')"

export CUSTOM_CODEBUILD_PR=''
if [ "${CUSTOM_CODEBUILD_GIT_BRANCH#pr-}" != "$CUSTOM_CODEBUILD_GIT_BRANCH" ] ; then
  export CUSTOM_CODEBUILD_PR=${CUSTOM_CODEBUILD_GIT_BRANCH#pr-};
fi

echo "CUSTOM_CODEBUILD_GIT_BRANCH = ${CUSTOM_CODEBUILD_GIT_BRANCH}"
echo "CUSTOM_CODEBUILD_GIT_BRANCH_CLEAN = ${CUSTOM_CODEBUILD_GIT_BRANCH_CLEAN}"
echo "CUSTOM_CODEBUILD_PR = ${CUSTOM_CODEBUILD_PR}"