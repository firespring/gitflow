#!/bin/bash

test_standalone_story_base_functionality()
{
  echo -e "\n\n"
  echo "------------------------------------------------------"
  echo "-------- EXECUTING STANDALONE STORY START ------------"
  echo "------------------------------------------------------"
  git flow standalone-story start $STORY1
  echo "--------------------- DONE ---------------------------"


  echo -e "\n\n"
  echo "------------------------------------------------------"
  echo "------------ EXECUTING RELEASE START -----------------"
  echo "------------------------------------------------------"
  git flow release start $RELEASE1
  echo "--------------------- DONE ---------------------------"


  echo -e "\n\n"
  echo "------------------------------------------------------"
  echo "-------- EXECUTING STANDALONE STORY FINISH -----------"
  echo "------------------------------------------------------"
  git flow standalone-story finish $STORY1 $RELEASE1
  echo "--------------------- DONE ---------------------------"


  echo -e "\n\n"
  echo "------------------------------------------------------"
  echo "------------ EXECUTING RELEASE FINISH ----------------"
  echo "------------------------------------------------------"
  git flow release finish $RELEASE1
  echo "--------------------- DONE ---------------------------"
}

test_standalone_story_multiple()
{
  echo -e "\n\n"
  echo "------------------------------------------------------"
  echo "-------- EXECUTING STANDALONE STORY LIST  ------------"
  echo "------------------------------------------------------"
  git flow standalone-story
  echo "--------------------- DONE ---------------------------"


  echo -e "\n\n"
  echo "------------------------------------------------------"
  echo "-------- EXECUTING STANDALONE STORY START ------------"
  echo "------------------------------------------------------"
  git flow standalone-story start $STORY1
  echo "--------------------- DONE ---------------------------"


  echo -e "\n\n"
  echo "------------------------------------------------------"
  echo "-------- EXECUTING STANDALONE STORY LIST  ------------"
  echo "------------------------------------------------------"
  git flow standalone-story list
  echo "--------------------- DONE ---------------------------"


  echo -e "\n\n"
  echo "------------------------------------------------------"
  echo "-------- EXECUTING STANDALONE STORY START ------------"
  echo "------------------------------------------------------"
  git flow standalone-story start $STORY2
  echo "--------------------- DONE ---------------------------"


  echo -e "\n\n"
  echo "------------------------------------------------------"
  echo "-------- EXECUTING STANDALONE STORY START ------------"
  echo "------------------------------------------------------"
  git flow standalone-story start --nopublish $STORY3
  echo "--------------------- DONE ---------------------------"


  echo -e "\n\n"
  echo "------------------------------------------------------"
  echo "-------- EXECUTING STANDALONE STORY LIST  ------------"
  echo "------------------------------------------------------"
  git flow standalone-story list
  echo "--------------------- DONE ---------------------------"


  echo -e "\n\n"
  echo "------------------------------------------------------"
  echo "------- EXECUTING STANDALONE STORY PUBLISH -----------"
  echo "------------------------------------------------------"
  git flow standalone-story publish $STORY3
  echo "--------------------- DONE ---------------------------"


  echo -e "\n\n"
  echo "------------------------------------------------------"
  echo "------------ EXECUTING RELEASE START -----------------"
  echo "------------------------------------------------------"
  git flow release start $RELEASE1
  echo "--------------------- DONE ---------------------------"


  echo -e "\n\n"
  echo "------------------------------------------------------"
  echo "-------- EXECUTING STANDALONE STORY FINISH -----------"
  echo "------------------------------------------------------"
  git flow standalone-story finish $STORY2 $RELEASE1
  echo "--------------------- DONE ---------------------------"


  echo -e "\n\n"
  echo "------------------------------------------------------"
  echo "-------- EXECUTING STANDALONE STORY FINISH -----------"
  echo "------------------------------------------------------"
  git flow standalone-story finish $STORY3 $RELEASE1
  echo "--------------------- DONE ---------------------------"


  echo -e "\n\n"
  echo "------------------------------------------------------"
  echo "-------- EXECUTING STANDALONE STORY FINISH -----------"
  echo "------------------------------------------------------"
  git flow standalone-story finish $STORY1 $RELEASE1
  echo "--------------------- DONE ---------------------------"


  echo -e "\n\n"
  echo "------------------------------------------------------"
  echo "------------ EXECUTING RELEASE FINISH ----------------"
  echo "------------------------------------------------------"
  git flow release finish $RELEASE1
  echo "--------------------- DONE ---------------------------"


  echo -e "\n\n"
  echo "------------------------------------------------------"
  echo "-------- EXECUTING STANDALONE STORY LIST  ------------"
  echo "------------------------------------------------------"
  git flow standalone-story list
  echo "--------------------- DONE ---------------------------"
}

test_standalone_story_finish_keep()
{
  echo -e "\n\n"
  echo "------------------------------------------------------"
  echo "-------- EXECUTING STANDALONE STORY START ------------"
  echo "------------------------------------------------------"
  git flow standalone-story start $STORY1
  echo "--------------------- DONE ---------------------------"


  echo -e "\n\n"
  echo "------------------------------------------------------"
  echo "------- EXECUTING STANDALONE STORY CHECKOUT ----------"
  echo "------------------------------------------------------"
  git flow standalone-story checkout $STORY1
  echo "--------------------- DONE ---------------------------"


  echo -e "\n\n"
  echo "------------------------------------------------------"
  echo "------------ EXECUTING RELEASE START -----------------"
  echo "------------------------------------------------------"
  git flow release start $RELEASE1
  echo "--------------------- DONE ---------------------------"


  echo -e "\n\n"
  echo "------------------------------------------------------"
  echo "-------- EXECUTING STANDALONE STORY FINISH -----------"
  echo "------------------------------------------------------"
  git flow standalone-story finish --keep $STORY1 $RELEASE1
  echo "--------------------- DONE ---------------------------"


  echo -e "\n\n"
  echo "------------------------------------------------------"
  echo "-------- EXECUTING STANDALONE STORY FINISH -----------"
  echo "------------------------------------------------------"
  git flow standalone-story finish --keep $STORY1 $RELEASE1
  echo "--------------------- DONE ---------------------------"


  echo -e "\n\n"
  echo "------------------------------------------------------"
  echo "-------- EXECUTING STANDALONE STORY DELETE -----------"
  echo "------------------------------------------------------"
  git flow standalone-story delete $STORY1
  echo "--------------------- DONE ---------------------------"


  echo -e "\n\n"
  echo "------------------------------------------------------"
  echo "------------ EXECUTING RELEASE FINISH ----------------"
  echo "------------------------------------------------------"
  git flow release finish $RELEASE1
  echo "--------------------- DONE ---------------------------"
}

set -e
. ./init.sh

pushd $TEST_DIR

test_standalone_story_base_functionality
test_standalone_story_multiple
test_standalone_story_finish_keep

popd

