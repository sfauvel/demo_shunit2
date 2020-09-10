#! /bin/bash

# Test awk

test_print_file_content() {
  OUTPUT=$(awk '{print $0}' ${TEXT_IN_FILE})

  assertContains "$OUTPUT" "some lines" 
}

test_find_the_lines_that_contain_something() {
  OUTPUT=$(awk '/line/ {print $0}' ${TEXT_IN_FILE})

  assertEquals "with some lines" "$OUTPUT"
}

test_display_line_number() {
  OUTPUT=$(awk '{print NR ":", $0}' ${TEXT_IN_FILE})
  
  assertContains "$OUTPUT" "1: Test file"
  assertContains "$OUTPUT" "2: with some lines"
  assertContains "$OUTPUT" "3: used to test awk command"
}

setUp() {
  testDir="${SHUNIT_TMPDIR}/sed"
  mkdir "${testDir}"

  TEXT_IN_VARIABLE=$(echo "Test file
with some lines
used to test awk command")

  TEXT_IN_FILE=${testDir}/file.txt
  echo "$TEXT_IN_VARIABLE" > ${TEXT_IN_FILE}
}

tearDown() {
  rm -fr "${testDir}"
}

# Load and run shUnit2.
SHUNIT2_PATH=../../shunit2
. ${SHUNIT2_PATH}/shunit2

