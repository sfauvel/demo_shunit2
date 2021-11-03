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

test_string_ends_with() {
  if [[ "my text with some words.end" == *with\ some ]]
  then
    fail "Substring should not be the end of string"
  fi

  if [[ "my text with some wordsXend" == *with\ some\ words.end ]]
  then
    fail "Substring should not be the end of string"
  fi
 
  if [[ ! "my text with some words.end" == *with\ some\ words.end ]]
  then
    fail "Substring should be the end of string"
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

test_find_lines_containing_a_text() {
  LINE=$(grep "some" <<< "${TEXT_IN_VARIABLE}")
  assertEquals "with some lines" "$LINE" 
}

test_find_last_line_in_multilines_text() {
  assertEquals "${TEXT_IN_VARIABLE##*$'\n'}" "used to test string commands" 
}

test_select_substring() {
  TEXT="0123456789"
  assertEquals "56" "${TEXT:5:2}" 
}

test_append_to_string() {
  local TMP=toto
  assertEquals "toto" "${TMP}" 
  TMP="$TMP;titi"
  assertEquals "toto;titi" "${TMP}" 
}


test_split_by_line() {
  TEXT_IN_VARIABLE=$(echo "Test file
with some lines
used to test")
  
 local index=0; while read -r line; do lines[$index]="$line";index=$(($index+1)); done <<< "$TEXT_IN_VARIABLE"

  assertEquals 3 $index
  assertEquals 3 ${#lines[*]}

  assertEquals "Test file" "${lines[0]}"
  assertEquals "with some lines" "${lines[1]}"
  assertEquals "used to test" "${lines[2]}"
}

test_split_by_line_when_starting_with_space() {
  TEXT_IN_VARIABLE=$(echo " Test file
  starting with space")
  
  IFS='\n'
  local index=0; while read -r line; do lines[$index]="$line";index=$(($index+1)); done <<< "$TEXT_IN_VARIABLE"
  unset IFS

  assertEquals " Test file" "${lines[0]}"
  assertEquals "  starting with space" "${lines[1]}"
}

test_remove_multi_space_in_string() {
  TEXT_IN_VARIABLE="line    with  words    separated  by  several    spaces"
  assertEquals "line with words separated by several spaces" "$(echo $TEXT_IN_VARIABLE | tr -s ' ')"
  
}

setUp() {
  TEXT_IN_VARIABLE=$(echo "Test file
with some lines
used to test string commands")
}

# Load and run shUnit2.
SHUNIT2_PATH=../../shunit2
. ${SHUNIT2_PATH}/shunit2

