#!/bin/bash
set -e
cd `dirname $0`

TEST_DIR="$1"
if [ "${TEST_DIR}" == "" ]
then
  echo 'No test directory specified'
  exit 1
fi

rm -rf $TEST_DIR
git clone --branch master git@github.com:jebmeier/test.git $TEST_DIR
pushd $TEST_DIR

# We want deletions to not exit on error
set +e
# Remove feature branch
git push origin :feature/TP-1234/develop > /dev/null 2>/dev/null
git branch -D feature/TP-1234/develop > /dev/null 2>/dev/null

# Remove release branch
git push origin :release/r751-1 > /dev/null 2>/dev/null
git branch -D release/r751-1 > /dev/null 2>/dev/null
git tag -d r751-1
git push origin :refs/tags/r751-1
set -e

git flow init -d


popd
