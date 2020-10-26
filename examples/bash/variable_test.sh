#! /bin/bash


test_set_default_value_when_variable_not_set() {
  unset VAR
  assertEquals "DEFAULT" "${VAR:-"DEFAULT"}"

  local VAR="VALUE" 
  assertEquals "VALUE" "${VAR:-"DEFAULT"}"
}

my_method() {
  local VAR=${1:-"DEFAULT"}
  echo $VAR
}

test_set_default_value_when_parameter_not_set() {
  
  assertEquals "VALUE" "$(my_method "VALUE")"

  assertEquals "DEFAULT" "$(my_method)"
}

test_global_variable_is_modified_from_function() {
  local VAR="X"
  assertEquals "X" $VAR

  set_global_variable "Z"
  assertEquals "Z" $VAR

}

test_global_variable_is_not_modified_when_it_local_in_function() {
  local VAR="X"
  assertEquals "X" $VAR

  set_local_variable "Z"
  assertEquals "X" $VAR

}

test_replace_string_in_variable() {
  local VAR="Hello world!"
  assertEquals "Hello everybody!" "${VAR/world/everybody}"
}

set_global_variable() {
  VAR="$1"
}

set_local_variable() {
  local VAR="$1"
}

# Load and run shUnit2.
SHUNIT2_PATH=../../shunit2
. ${SHUNIT2_PATH}/shunit2

