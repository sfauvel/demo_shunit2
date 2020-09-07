#! /bin/bash

# Execute git command wihout output
GIT() {
  git "$@" > /dev/null
}

test_init_repo_and_commit_one_file() {  
  init_and_add_file
  GIT commit -m "First commit" 
  assertContains "$(git log --oneline)" " First commit"
}

test_file_status_before_add() {
  GIT init 
  echo "Hello" > file.txt  
  assertEquals "?? file.txt" "$(git status -s --no-renames)"
}

test_file_status_after_add() {
  init_and_add_file
  
  assertEquals "A  file.txt" "$(git status -s --no-renames)"
}

test_file_status_after_commit() {
  init_and_add_file
  GIT commit -m "First commit" 

  assertEquals "" "$(git status -s --no-renames)"
}

test_file_status_after_modified() {
  init_and_add_file 
  GIT commit -m "First commit" 
  echo " World!" >> file.txt  

  assertEquals " M file.txt" "$(git status -s --no-renames)"
}

test_file_status_after_modified_and_add() {
  init_and_add_file  
  GIT commit -m "First commit" 
  echo " World!" >> file.txt  
  git add file.txt 

  assertEquals "M  file.txt" "$(git status -s --no-renames)" 
}

test_file_diff_after_modified() {
  init_and_add_file
  GIT commit -m "First commit"
  echo " World!" >> file.txt  

  assertContains "$(echo $(git diff))" "--- a/file.txt +++ b/file.txt"
  assertContains "$(echo $(git diff))" "Hello + World!"

  assertEquals "" "$(git diff --staged)"
}

test_file_diff_after_modified_and_add() {
  init_and_add_file
  GIT commit -m "First commit"
  echo " World!" >> file.txt  
  GIT add file.txt 

  assertEquals "" "$(git diff)"
  assertContains "$(echo $(git diff --staged))" "--- a/file.txt +++ b/file.txt"
  assertContains "$(echo $(git diff --staged))" "Hello + World!"
}

test_file_diff_remove_file_from_disk() {
  init_and_add_file
  GIT commit -m "First commit"
  rm file.txt 

  assertContains "$(echo $(git diff))" "--- a/file.txt +++ /dev/null"
  assertContains "$(echo $(git diff))" "deleted file"
  assertEquals "" "$(git diff --staged)"
}

test_file_diff_remove_file_from_git_index() {
  init_and_add_file
  GIT commit -m "First commit"
  GIT rm file.txt 

  assertContains "$(echo $(git diff))" ""
  assertContains "$(echo $(git diff --staged))" "--- a/file.txt +++ /dev/null"
  assertContains "$(echo $(git diff --staged))" "deleted file"
}

init_and_add_file() {
  GIT init  
  echo "Hello" > file.txt
  GIT add file.txt  
}

setUp() {
  TEST_NUMBER=$(($TEST_NUMBER+1))
  mkdir ${SHUNIT_TMPDIR}/gittest_$TEST_NUMBER  > /dev/null
  pushd ${SHUNIT_TMPDIR}/gittest_$TEST_NUMBER  > /dev/null
}

tearDown() {
  popd  > /dev/null
  rm -rf ${SHUNIT_TMPDIR}/*
}

TEST_NUMBER=0


# Load and run shUnit2.
SHUNIT2_PATH=../../shunit2
. ${SHUNIT2_PATH}/shunit2

