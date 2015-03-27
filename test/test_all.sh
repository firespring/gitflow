#!/bin/bash
set -e
cd `dirname $0`

echo "STARTED TESTING"

./prepare.sh './test'
./test_features.sh './test'

echo "TESTING FINISHED SUCCESSFULLY!"
