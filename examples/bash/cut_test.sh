#! /bin/bash

# Test cut function

test_cut_string_by_space() {
  TEXT="Some text to split"
  RESULT=$(cut -d ' ' -f 2 <<< "$TEXT")
  assertEquals "text" "$RESULT"
}

test_cut_string_by_mutli_spaces() {
  TEXT="Some    text   to     split"
  RESULT=$(cut -d ' ' -f 2 <<< "$(echo $TEXT | tr -s ' ')")
  assertEquals "text" "$RESULT"
}


# Load and run shUnit2.
SHUNIT2_PATH=../../shunit2
. ${SHUNIT2_PATH}/shunit2

