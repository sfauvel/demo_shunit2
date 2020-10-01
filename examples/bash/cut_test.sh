#! /bin/bash

# Test cut function

test_assert_contains_found_text_in_string() {
  TEXT="Some text to split"
  RESULT=$(cut -d ' ' -f 2 <<< "$TEXT")
  assertEquals "text" "$RESULT"
}

# Load and run shUnit2.
SHUNIT2_PATH=../../shunit2
. ${SHUNIT2_PATH}/shunit2

