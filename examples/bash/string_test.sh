#! /bin/bash

# Test sed.
# http://tldp.org/LDP/abs/html/string-manipulation.html

test_assert_contains_found_text_in_string() {
  assertContains "$TEXT_IN_VARIABLE" "some lines" 
}

test_search_text_present_in_string() {
  if [[ ! "my text with some words" =~ "with some" ]]
  then
    fail "Substring should be found in string"
  fi
}

test_search_text_not_present_in_string() {
  if [[ "my text with some words" =~ "text not in string" ]]
  then
    fail "Substring should not be found in string"
  fi
}

test_replace_text_in_string() {
  TEXT_IN_VARIABLE=${TEXT_IN_VARIABLE/some lines/one line}
  assertContains "$TEXT_IN_VARIABLE" "one line" 
}

test_find_a_string_in_a_multilines_text() {
  TMP=${TEXT_IN_VARIABLE//$'\n'/' '} # replace line break by space to have all text in one line.
  assertContains "${TMP}" "file with" 
  assertContains "${TEXT_IN_VARIABLE//$'\n'/' '}" "file with" 
}

test_find_last_line_in_multilines_text() {
  assertEquals "${TEXT_IN_VARIABLE##*$'\n'}" "used to test string commands" 
}

test_append_to_string() {
  local TMP=toto
  assertEquals "toto" "${TMP}" 
  TMP="$TMP;titi"
  assertEquals "toto;titi" "${TMP}" 
}

setUp() {
  TEXT_IN_VARIABLE=$(echo "Test file
with some lines
used to test string commands")
}

# Load and run shUnit2.
SHUNIT2_PATH=../../shunit2
. ${SHUNIT2_PATH}/shunit2

