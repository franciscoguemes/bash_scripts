#!/usr/bin/env bash

function warn_in_case_of_error() {
  grep -q ERROR <<< "$1"
  local -r grep_return_code=$?

  if [ $grep_return_code -eq 0 ]; then
    if [ -n "$2" ]; then
      echo "$2"
    fi
    echo "$1"
    return 1
  fi
  return 0
}

function exit_in_case_of_error() {
  warn_in_case_of_error "$1" "$2"
  if [ $? -eq 1 ]; then
    exit 1
  fi
}













