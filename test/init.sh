#!/bin/bash
set -e
cd `dirname $0`

export TEST_DIR="$1"
if [ "${TEST_DIR}" = "" ]
then
  echo 'No test directory specified'
  exit 1
fi

rm -rf $TEST_DIR
git clone --branch master git@github.com:jebmeier/test.git $TEST_DIR 2> /dev/null > /dev/null

pushd $TEST_DIR
git flow init -d 2> /dev/null > /dev/null
popd

. ./variables.sh
