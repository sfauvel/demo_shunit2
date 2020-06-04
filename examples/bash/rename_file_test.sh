#! /bin/bash

test_replace_only_first_mathing_character_by_default() {

  pushd ${testDir}
  rename 's/a/A/' *.txt
  popd

  assertContains "$(files_list ${testDir})" "Abca.txt;" 
}

test_replace_all_matching_with_option_g() {

  pushd ${testDir}
  rename 's/a/A/g' *.txt
  popd

  assertContains "$(files_list ${testDir})" "AbcA.txt;" 

}

test_rename_all_files_in_directory() {

  pushd ${testDir}
  rename 's/^([a-z]+)/\U$1/' *.txt
  popd

  assertContains "$(files_list ${testDir})" "ABCA.txt;XYZ.txt;" 
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

setUp() {
  testDir="${SHUNIT_TMPDIR}/file"
  mkdir "${testDir}"
  
  pushd ${testDir}
  touch "abca.txt"
  touch "xyz.txt"
  popd
}

tearDown() {
  rm -fr "${testDir}"
}

# Load and run shUnit2.
SHUNIT2_PATH=../../shunit2
. ${SHUNIT2_PATH}/shunit2

