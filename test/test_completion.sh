#!/bin/bash

source /etc/bash_completion.d/git
source /etc/bash_completion.d/git-flow-completion.bash

test_feature_completion()
{
  echo -e "\n\n"
  echo "------------------------------------------------------"
  echo "---------- TESTING FEATURE COMPLETION ----------------"
  echo "------------------------------------------------------"

  COMP_WORDS=( git flow feature )
  test_completion_matches "list start finish publish track diff rebase checkout pull help delete"

  COMP_WORDS=( git flow feature finish )
  test_completion_matches ""

  # Create a feature so we can find it with auto-completion
  git flow feature start $FEATURE1

  COMP_WORDS=( git flow feature finish '' )
  test_completion_matches "$FEATURE1"

  # Create a release so we can find it with auto-completion
  git flow release start $RELEASE1

  COMP_WORDS=( git flow feature finish $FEATURE1 '' )

  test_completion_matches "$RELEASE1"

  echo "--------------------- DONE ---------------------------"
}

test_completion_matches()
{
  COMP_CWORD=${#COMP_WORDS[*]}

  comp_string="$1"
  result="`_git && echo ${COMPREPLY[*]}`"
  if [ "$comp_string" != "$result" ]
  then
    echo "Actual completion result ($result) does not match expected result ($comp_string)"
    exit 1
  fi

  echo "Expected text ($comp_string) found"
}

set -e
. ./init.sh

pushd $TEST_DIR

test_feature_completion

popd

