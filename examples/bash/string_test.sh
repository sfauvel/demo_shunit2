#! /bin/bash

# Test sed.
# http://tldp.org/LDP/abs/html/string-manipulation.html

test_found_text_in_string() {
  assertContains "$TEXT_IN_VARIABLE" "some lines" 
}

test_replace_text_in_string() {
  TEXT_IN_VARIABLE=${TEXT_IN_VARIABLE/some lines/one line}
  assertContains "$TEXT_IN_VARIABLE" "one line" 
}

test_find_a_string_in_a_multilines_text() {
  TMP=${TEXT_IN_VARIABLE//$'\n'/' '}
  assertContains "${TMP}" "file with" 
  assertContains "${TEXT_IN_VARIABLE//$'\n'/' '}" "file with" 
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
used to test sed command")
}

# Load and run shUnit2.
SHUNIT2_PATH=../../shunit2
. ${SHUNIT2_PATH}/shunit2

