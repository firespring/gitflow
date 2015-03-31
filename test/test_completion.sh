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

  # Create a feature so we can find it with auto-completion
  git flow feature start $FEATURE1

  COMP_WORDS=( git flow feature checkout '' )
  test_completion_matches "$FEATURE1"

  COMP_WORDS=( git flow feature publish '' )
  test_completion_matches "$FEATURE1"

  COMP_WORDS=( git flow feature delete '' )
  test_completion_matches "$FEATURE1"

  COMP_WORDS=( git flow feature finish '' )
  test_completion_matches "$FEATURE1"

  # Create a release so we can find it with auto-completion
  git flow release start $RELEASE1

  COMP_WORDS=( git flow feature finish $FEATURE1 '' )
  test_completion_matches "$RELEASE1"

  git flow feature delete $FEATURE1 $RELEASE1
  git flow release delete $RELEASE1

  echo "--------------------- DONE ---------------------------"
}

test_story_completion()
{
  echo -e "\n\n"
  echo "------------------------------------------------------"
  echo "----------- TESTING STORY COMPLETION -----------------"
  echo "------------------------------------------------------"

  # Create a release so we can find it with auto-completion
  git flow feature start $FEATURE1
  git flow feature start $FEATURE2

  COMP_WORDS=( git flow story list '' )
  test_completion_matches "$FEATURE1 $FEATURE2"

  COMP_WORDS=( git flow story start '' )
  test_completion_matches "$FEATURE1 $FEATURE2"

  git flow story start $FEATURE1 $STORY1

  COMP_WORDS=( git flow story checkout '' )
  test_completion_matches "$STORY1"

  COMP_WORDS=( git flow story publish '' )
  test_completion_matches "$STORY1"

  COMP_WORDS=( git flow story delete '' )
  test_completion_matches "$STORY1"

  COMP_WORDS=( git flow story finish '' )
  test_completion_matches "$STORY1"


  git flow story delete $STORY1
  git flow feature delete $FEATURE1
  git flow feature delete $FEATURE2

  echo "--------------------- DONE ---------------------------"
}

test_standalone_story_completion()
{
  echo -e "\n\n"
  echo "------------------------------------------------------"
  echo "---------- TESTING STANDALONE STORY COMPLETION ----------------"
  echo "------------------------------------------------------"

  COMP_WORDS=( git flow standalone-story )
  test_completion_matches "list start finish publish track diff rebase checkout pull help delete"

  # Create a standalone-story so we can find it with auto-completion
  git flow standalone-story start $STORY1

  COMP_WORDS=( git flow standalone-story checkout '' )
  test_completion_matches "$STORY1"

  COMP_WORDS=( git flow standalone-story publish '' )
  test_completion_matches "$STORY1"

  COMP_WORDS=( git flow standalone-story delete '' )
  test_completion_matches "$STORY1"

  COMP_WORDS=( git flow standalone-story finish '' )
  test_completion_matches "$STORY1"

  # Create a release so we can find it with auto-completion
  git flow release start $RELEASE1

  COMP_WORDS=( git flow standalone-story finish $STORY1 '' )
  test_completion_matches "$RELEASE1"

  git flow standalone-story delete $STORY1 $RELEASE1
  git flow release delete $RELEASE1

  echo "--------------------- DONE ---------------------------"
}

test_release_completion()
{
  echo -e "\n\n"
  echo "------------------------------------------------------"
  echo "---------- TESTING RELEASE COMPLETION ----------------"
  echo "------------------------------------------------------"

  COMP_WORDS=( git flow release )
  test_completion_matches "list start checkout finish track publish help delete"

  COMP_WORDS=( git flow release finish )
  test_completion_matches ""

  # Create a release so we can find it with auto-completion
  git flow release start $RELEASE1

  COMP_WORDS=( git flow release finish '' )
  test_completion_matches "$RELEASE1"

  COMP_WORDS=( git flow release checkout '' )
  test_completion_matches "$RELEASE1"

  COMP_WORDS=( git flow release publish '' )
  test_completion_matches "$RELEASE1"

  COMP_WORDS=( git flow release delete '' )
  test_completion_matches "$RELEASE1"

  git flow release delete $RELEASE1

  echo "--------------------- DONE ---------------------------"
}

test_hotfix_completion()
{
  echo -e "\n\n"
  echo "------------------------------------------------------"
  echo "---------- TESTING HOTFIX COMPLETION ----------------"
  echo "------------------------------------------------------"

  COMP_WORDS=( git flow hotfix )
  test_completion_matches "list start checkout finish track publish help delete"

  COMP_WORDS=( git flow hotfix finish )
  test_completion_matches ""

  # Create a hotfix so we can find it with auto-completion
  git flow hotfix start $HOTFIX1

  COMP_WORDS=( git flow hotfix finish '' )
  test_completion_matches "$HOTFIX1"

  COMP_WORDS=( git flow hotfix checkout '' )
  test_completion_matches "$HOTFIX1"

  COMP_WORDS=( git flow hotfix publish '' )
  test_completion_matches "$HOTFIX1"

  COMP_WORDS=( git flow hotfix delete '' )
  test_completion_matches "$HOTFIX1"

  git flow hotfix delete $HOTFIX1

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
test_story_completion
test_standalone_story_completion
test_release_completion
test_hotfix_completion

popd

