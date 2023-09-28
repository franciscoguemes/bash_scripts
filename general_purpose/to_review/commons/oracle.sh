#!/usr/bin/env bash


function warn_in_case_of_oracle_error() {
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

function exit_in_case_of_oracle_error() {
  warn_in_case_of_oracle_error "$1" "$2"
  if [ $? -eq 1 ]; then
    exit 1
  fi
}

function execute_sql_on_PS() {
  local -r SQL="$1"
#  echo "Script to be executed:"
#  echo "$SQL"
#  echo "${AWS_PS_USER}/${AWS_PS_PASSWORD}@//${AWS_PS_HOST}:${AWS_PS_PORT}/${AWS_PS_SERVICE_NAME}"
OUTPUT=`sqlplus -S ${AWS_PS_USER}/${AWS_PS_PASSWORD}@//${AWS_PS_HOST}:${AWS_PS_PORT}/${AWS_PS_SERVICE_NAME} << EOF
    $SQL
    exit
EOF`
  status_code=$?
  echo "$OUTPUT"
  return $status_code
}

function execute_sql_on_MTP() {
  local -r SQL="$1"
#  echo "Script to be executed:"
#  echo "$SQL"
#  echo "${AWS_MTP_USER}/${AWS_MTP_PASSWORD}@//${AWS_MTP_HOST}:${AWS_MTP_PORT}/${AWS_MTP_SERVICE_NAME}"
OUTPUT=`sqlplus -S ${AWS_MTP_USER}/${AWS_MTP_PASSWORD}@//${AWS_MTP_HOST}:${AWS_MTP_PORT}/${AWS_MTP_SERVICE_NAME} << EOF
    $SQL
    exit
EOF`
  #status_code=$?
  echo "$OUTPUT"
  #return $status_code
}


function vefify_connection_to_PS() {
  OUTPUT=$(execute_sql_on_PS "")
  exit_in_case_of_oracle_error "$OUTPUT" "Error connecting to PS"
}

function vefify_connection_to_MTP() {
  OUTPUT=$(execute_sql_on_MTP "")
  exit_in_case_of_oracle_error "$OUTPUT" "Error connecting to MTP"
}

function verify_connections() {
  vefify_connection_to_PS
  vefify_connection_to_MTP
}
