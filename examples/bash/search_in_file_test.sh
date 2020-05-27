#! /bin/bash

# Test sed.
# http://tldp.org/LDP/abs/html/string-manipulation.html

test_found_text_in_file() {
  assertContains "$(cat $TEXT_IN_FILE)" "some lines" 
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
