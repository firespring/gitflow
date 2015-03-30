#!/bin/bash
set -e
cd `dirname $0`

. ./init.sh
pushd $TEST_DIR

# We want deletions to not exit on error
set +e

# Remove feature branch
echo "Removing feature branches ($FEATURE1)"
git push origin :feature/$FEATURE1/develop > /dev/null 2>/dev/null
git branch -D feature/$FEATURE1/develop > /dev/null 2>/dev/null

# Remove release branch
echo "Removing relase branches ($RELEASE1)"
git push origin :release/$RELEASE1 > /dev/null 2>/dev/null
git branch -D release/$RELEASE1 > /dev/null 2>/dev/null
git tag -d $RELEASE1  > /dev/null 2>/dev/null
git push origin :refs/tags/$REELASE1 > /dev/null 2>/dev/null

set -e

popd

# Removing the test directory
rm -rf ${TEST_DIR}
