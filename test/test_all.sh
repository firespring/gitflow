#!/bin/bash
set -e
cd `dirname $0`

echo "STARTED TESTING"

test_directory="`pwd`/test"

# Start with a clean workspace
./clean.sh $test_directory

./test_features.sh $test_directory
./test_completion.sh $test_directory

# Finish with a clean workspace
#./clean.sh $test_directory

echo "TESTING FINISHED SUCCESSFULLY!"
