#!/bin/bash
set -e
cd `dirname $0`

if [ -d ~/.env ] || [ "$TP_USERNAME" != "" ] || [ "$TP_PASSWORD" != "" ] || [ "$TP_URL" != "" ]
then
  echo "Targetprocess credentials found. Please remove before running tests"
  exit 1
fi

echo "STARTED TESTING"

test_directory="`pwd`/test"

# Start with a clean workspace
./clean.sh $test_directory

./test_features.sh $test_directory
./test_stories.sh $test_directory
./test_standalone_stories.sh $test_directory
./test_releases.sh $test_directory
./test_hotfixes.sh $test_directory
./test_completion.sh $test_directory

# Finish with a clean workspace
./clean.sh $test_directory

echo "TESTING FINISHED SUCCESSFULLY!"
