#! /bin/bash

# Test sed.
# http://tldp.org/LDP/abs/html/string-manipulation.html

test_full_file_path() {
  assertEquals "${testDir}/test_file.txt" "${TEST_FILE}" 
}

test_filename_without_extension() {
  FILENAME="file.txt"
  assertEquals "file" "${FILENAME%%.*}" 
}

test_extension_file() {
  FILENAME="file.txt"
  assertEquals "txt" "${FILENAME##*.}" 
}

test_remove_folder_from_file_path() {
  FILEPATH="${testDir}/file.txt"
  assertEquals "file.txt" "${FILEPATH##*/}" 
}

test_loop_over_files() {
  touch "${testDir}/aaa.txt"
  touch "${testDir}/bbb.txt"

  local FILES=""
  for file in ${testDir}/*
  do
    FILES="$FILES${file##*/};"
  done
  assertEquals "aaa.txt;bbb.txt;" "${FILES}"

}

test_loop_over_files_with_space_in_name() {
  touch "${testDir}/a a a.txt"
  touch "${testDir}/b b b.txt"

  local FILES=""
  for file in ${testDir}/*
  do
    FILES="$FILES${file##*/};"
  done
  assertEquals "a a a.txt;b b b.txt;" "${FILES}"

}

# Display files in folder
files_list() {
  local FILES=""
  for file in $1/*
  do
    FILES="$FILES${file##*/};"
  done
  echo $FILES
}

test_chmod_with_space() {
  FILE="${testDir}/a a a.txt"
  touch "${FILE}"
  chmod 700 "${FILE}"
  chmod g+w "${FILE}"
  REGEXP="-...-w-...*"
  RIGHTS="$(ls -al "${FILE}")"

  if [[ ! "$RIGHTS" =~ $REGEXP ]]; then
    fail "Regexp '${REGEXP}' does not match with '$RIGHTS'"
  fi
}

test_chmod_with_space_and_wildcard() {
  FILE_A="${testDir}/a a a.txt"
  FILE_B="${testDir}/b b b.txt"
  touch "${FILE_A}"
  touch "${FILE_B}"
  chmod 700 "${FILE_A}"
  chmod 700 "${FILE_B}"
  
  chmod g+w ${testDir}/*.txt
  
  REGEXP="-...-w-...*"
  
  RIGHTS="$(ls -al "${FILE_A}")"
  if [[ ! "$RIGHTS" =~ $REGEXP ]]; then
    fail "Regexp '${REGEXP}' does not match with '$RIGHTS'"
  fi

  RIGHTS="$(ls -al "${FILE_B}")"
  if [[ ! "$RIGHTS" =~ $REGEXP ]]; then
    fail "Regexp '${REGEXP}' does not match with '$RIGHTS'"
  fi
  
}

test_chmod_with_space_in_file_and_path_and_with_wildcard() {
  testDirWithSpaces="${testDir}/folder with space"
  mkdir "${testDirWithSpaces}"
  FILE_A="${testDirWithSpaces}/a a a.txt"
  touch "${FILE_A}"
  chmod 700 "${FILE_A}"
  
  # asteric must be outside of the string
  chmod g+w "${testDirWithSpaces}/"*.txt
  
  REGEXP="-...-w-...*"
  
  RIGHTS="$(ls -al "${FILE_A}")"
  if [[ ! "$RIGHTS" =~ $REGEXP ]]; then
    fail "Regexp '${REGEXP}' does not match with '$RIGHTS'"
  fi

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

