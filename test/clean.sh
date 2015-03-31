#!/bin/bash
set -e
cd `dirname $0`

. ./init.sh
pushd $TEST_DIR

# We want deletions to not exit on error
set +e

# Remove feature branches
echo "Removing feature branch ($FEATURE1)"
git push origin :feature/$FEATURE1/develop > /dev/null 2>/dev/null
git branch -D feature/$FEATURE1/develop > /dev/null 2>/dev/null

echo "Removing feature branch ($FEATURE2)"
git push origin :feature/$FEATURE2/develop > /dev/null 2>/dev/null
git branch -D feature/$FEATURE2/develop > /dev/null 2>/dev/null

echo "Removing feature branch ($FEATURE3)"
git push origin :feature/$FEATURE3/develop > /dev/null 2>/dev/null
git branch -D feature/$FEATURE3/develop > /dev/null 2>/dev/null

# Remove story branches
echo "Removing story branch ($STORY1)"
git push origin :feature/$FEATURE1/story/$STORY1 > /dev/null 2>/dev/null
git branch -D feature/$FEATURE1/story/$STORY1 > /dev/null 2>/dev/null

echo "Removing story branch ($STORY2)"
git push origin :feature/$FEATURE2/story/$STORY2 > /dev/null 2>/dev/null
git branch -D feature/$FEATURE2/story/$STORY2 > /dev/null 2>/dev/null

echo "Removing story branch ($STORY3)"
git push origin :feature/$FEATURE2/story/$STORY3 > /dev/null 2>/dev/null
git branch -D feature/$FEATURE2/story/$STORY3 > /dev/null 2>/dev/null

# Remove standalone-story branches
echo "Removing standalone-story branch ($STORY1)"
git push origin :story/$STORY1 > /dev/null 2>/dev/null
git branch -D /story/$STORY1 > /dev/null 2>/dev/null

echo "Removing standalone-story branch ($STORY2)"
git push origin :story/$STORY2 > /dev/null 2>/dev/null
git branch -D story/$STORY2 > /dev/null 2>/dev/null

echo "Removing standalone-story branch ($STORY3)"
git push origin :story/$STORY3 > /dev/null 2>/dev/null
git branch -D story/$STORY3 > /dev/null 2>/dev/null

# Remove release branches
echo "Removing release branch ($RELEASE1)"
git push origin :release/$RELEASE1 > /dev/null 2>/dev/null
git branch -D release/$RELEASE1 > /dev/null 2>/dev/null
git tag -d $RELEASE1  > /dev/null 2>/dev/null
git push origin :refs/tags/$RELEASE1 > /dev/null 2>/dev/null

echo "Removing release branch ($RELEASE2)"
git push origin :release/$RELEASE2 > /dev/null 2>/dev/null
git branch -D release/$RELEASE2 > /dev/null 2>/dev/null
git tag -d $RELEASE2  > /dev/null 2>/dev/null
git push origin :refs/tags/$RELEASE2 > /dev/null 2>/dev/null

echo "Removing release branch ($RELEASE3)"
git push origin :release/$RELEASE3 > /dev/null 2>/dev/null
git branch -D release/$RELEASE3 > /dev/null 2>/dev/null
git tag -d $RELEASE3  > /dev/null 2>/dev/null
git push origin :refs/tags/$RELEASE3 > /dev/null 2>/dev/null

# Remove hotfix branches
echo "Removing hotfix branch ($HOTFIX1)"
git push origin :hotfix/$HOTFIX1 > /dev/null 2>/dev/null
git branch -D hotfix/$HOTFIX1 > /dev/null 2>/dev/null
git tag -d $HOTFIX1  > /dev/null 2>/dev/null
git push origin :refs/tags/$HOTFIX1 > /dev/null 2>/dev/null

# Turn back on exit on failure functionality
set -e

popd

# Removing the test directory
rm -rf ${TEST_DIR}
