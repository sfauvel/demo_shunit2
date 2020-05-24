#! /bin/bash

# Test sed.
# http://tldp.org/LDP/abs/html/string-manipulation.html

testFullFilePath() {
  assertEquals "${testDir}/test_file.txt" "${TEST_FILE}" 
}

testFileNameWithoutExtension() {
  FILENAME="file.txt"
  assertEquals "file" "${FILENAME%%.*}" 
}

testExtensionFile() {
  FILENAME="file.txt"
  assertEquals "txt" "${FILENAME##*.}" 
}

testRemoveFolderFromFilePath() {
  FILEPATH="${testDir}/file.txt"
  assertEquals "file.txt" "${FILEPATH##*/}" 
}

setUp() {
  testDir="${SHUNIT_TMPDIR}/file"
  mkdir "${testDir}"

  TEST_FILE=${testDir}/test_file.txt
}

tearDown() {
  rm -fr "${testDir}"
}

# Load and run shUnit2.
SHUNIT2_PATH=../../shunit2
. ${SHUNIT2_PATH}/shunit2

