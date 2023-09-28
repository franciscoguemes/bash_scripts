#!/usr/bin/env bash



function surround_with_double_quotes() {
  local -r input=$1
  echo "\"${input}\""
}

function csv_to_json_array {
  local -r input=$(surround_with_double_quotes "$1")
  local -r json_array=$( echo "${input}" | jq 'split(",")' | jq -r tostring )
  echo "$json_array"
}

function multi_line_string_to_csv {
  local -r input="$1"
  local output=$(echo "$input" | paste -sd "," -)
  echo $output
}

function multi_line_string_to_single_line_string {
  local -r input="$1"
  local output=$(echo "$input" | paste -sd " " -)
  echo $output
}


function trim() {
    local trimmed="$1"
    # Strip leading space.
    trimmed="${trimmed## }"
    # Strip trailing space.
    trimmed="${trimmed%% }"
    echo "$trimmed"
}


function get_the_last_line() {
    last_line=`tail -n 1 << EOF
      $1
EOF`
    echo "$last_line"
}


function delete_empty_lines() {
    sed '/^$/d' <<< "$1"
}
