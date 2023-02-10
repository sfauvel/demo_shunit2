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
  sed -i 's/test \(.*\) command/test XXX \1 XXX command/' ${TEXT_IN_FILE}

  assertContains "$(cat $TEXT_IN_FILE)" "test XXX sed XXX command" 
}

test_replace_text_with_group_a_z() {
  sed -i 's/test \([a-z]*\) command/test XXX \1 XXX command/' ${TEXT_IN_FILE}
  assertContains "$(cat $TEXT_IN_FILE)" "test XXX sed XXX command" 
}

test_replace_text_with_group_word() {
  sed -i 's/test sed \(\w*\)/test sed x\1x/' ${TEXT_IN_FILE}
  assertContains "$(cat $TEXT_IN_FILE)" "test sed xcommandx" 
}

test_replace_text_in_a_variable() {
  # Use double quote to extend variable content
  replace_text=xyz
  sed -i "s/test sed command/test sed ${replace_text}command/" ${TEXT_IN_FILE}
  assertContains "$(cat $TEXT_IN_FILE)" "test sed xyzcommand" 
}
test_replace_all_in_file() {

  # Add option `g` to replace all occurences
  sed -i "s/e/x/g" ${TEXT_IN_FILE}

  assertContains "$(cat $TEXT_IN_FILE)" "Txst filx" 
}

test_multiple_replacement() {

  # Add option `g` to replace all occurences
  sed -i "s/e/x/g ; s/i/y/g" ${TEXT_IN_FILE}

  assertContains "$(cat $TEXT_IN_FILE)" "Txst fylx" 
}

setUp() {
  testDir="${SHUNIT_TMPDIR}/sed"
  mkdir "${testDir}"

  TEXT_IN_VARIABLE=$(echo "Test file
with some lines
used to test sed command")

  TEXT_IN_FILE=${testDir}/file.txt
  echo "$TEXT_IN_VARIABLE" > ${TEXT_IN_FILE}
}

tearDown() {
  rm -fr "${testDir}"
}

# Load and run shUnit2.
SHUNIT2_PATH=../../shunit2
. ${SHUNIT2_PATH}/shunit2

