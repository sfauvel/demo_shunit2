#! /bin/bash

# Test sed.
# http://tldp.org/LDP/abs/html/string-manipulation.html

test_found_text_in_file() {
  assertContains "$(cat $TEXT_IN_FILE)" "some lines" 
}

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

setUp() {
  testDir="${SHUNIT_TMPDIR}/sed"
  mkdir "${testDir}"

  TEXT_IN_VARIABLE=$(echo "Test file
with some lines
used to test sed command")

  TEXT_IN_FILE=${testDir}/file.txt
  echo $TEXT_IN_VARIABLE > ${TEXT_IN_FILE}
}

tearDown() {
  rm -fr "${testDir}"
}

# Load and run shUnit2.
SHUNIT2_PATH=../../shunit2
. ${SHUNIT2_PATH}/shunit2

