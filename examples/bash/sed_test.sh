#! /bin/bash

# Test sed.
# http://tldp.org/LDP/abs/html/string-manipulation.html

test_replace_text_in_file() {

  sed -i "s/some lines/one line/" ${TEXT_IN_FILE}

  assertContains "$(cat $TEXT_IN_FILE)" "one line" 
}

test_replace_text_in_file_ignoring_case() {
  # Add option `I` to ignore case
  sed -i "s/Some lines/one line/I" ${TEXT_IN_FILE}

  assertContains "$(cat $TEXT_IN_FILE)" "one line" 
}

test_replace_text_with_group() { 
  sed -i 's/some \(.*\) used/some x\1x used/' ${TEXT_IN_FILE}
  assertContains "$(cat $TEXT_IN_FILE)" "some xlinesx used" 
}

test_replace_text_with_group_a_z() {
  sed -i 's/test sed \([a-z]*\)/test sed x\1x/' ${TEXT_IN_FILE}
  assertContains "$(cat $TEXT_IN_FILE)" "test sed xcommandx" 
}

test_replace_text_with_group_word() {
  sed -i 's/test sed \(\w*\)/test sed x\1x/' ${TEXT_IN_FILE}
  assertContains "$(cat $TEXT_IN_FILE)" "test sed xcommandx" 
}

test_replace_all_in_file() {

  # Add option `g` to replace all occurences
  sed -i "s/e/x/g" ${TEXT_IN_FILE}

  assertContains "$(cat $TEXT_IN_FILE)" "Txst filx" 
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

