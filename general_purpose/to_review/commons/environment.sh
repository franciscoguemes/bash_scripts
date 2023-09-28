#                 - AWS_PS_HOST
#                 - AWS_PS_PORT
#                 - AWS_PS_USER
#                 - AWS_PS_PASSWORD
#                 - AWS_PS_SERVICE_NAME
#                 - AWS_PS_SOURCE_SCHEMA
function check_aws_ps_environment_variables() {
  local return_code=0
  if [[ -z "${AWS_PS_HOST}" ]]; then
    echo "The required environment variable AWS_PS_HOST do not exists"
    return_code=1;
  fi
  if [[ -z "${AWS_PS_PORT}" ]]; then
    echo "The required environment variable AWS_PS_PORT do not exists"
    return_code=1;
  fi
  if [[ -z "${AWS_PS_USER}" ]]; then
    echo "The required environment variable AWS_PS_USER do not exists"
    return_code=1;
  fi
  if [[ -z "${AWS_PS_PASSWORD}" ]]; then
    echo "The required environment variable AWS_PS_PASSWORD do not exists"
    return_code=1;
  fi
  if [[ -z "${AWS_PS_SERVICE_NAME}" ]]; then
    echo "The required environment variable AWS_PS_SERVICE_NAME do not exists"
    return_code=1;
  fi
  if [[ -z "${AWS_PS_SOURCE_SCHEMA}" ]]; then
    echo "The required environment variable AWS_PS_SOURCE_SCHEMA do not exists"
    return_code=1;
  fi
  return $return_code;
}


#                 - AWS_MTP_HOST
#                 - AWS_MTP_PORT
#                 - AWS_MTP_USER
#                 - AWS_MTP_PASSWORD
#                 - AWS_MTP_SERVICE_NAME
#                 - AWS_MTP_SOURCE_SCHEMA
function check_aws_mtp_environment_variables() {
  local return_code=0
  if [[ -z "${AWS_MTP_HOST}" ]]; then
    echo "The required environment variable AWS_MTP_HOST do not exists"
    return_code=1;
  fi
  if [[ -z "${AWS_MTP_PORT}" ]]; then
    echo "The required environment variable AWS_MTP_PORT do not exists"
    return_code=1;
  fi
  if [[ -z "${AWS_MTP_USER}" ]]; then
    echo "The required environment variable AWS_MTP_USER do not exists"
    return_code=1;
  fi
  if [[ -z "${AWS_MTP_PASSWORD}" ]]; then
    echo "The required environment variable AWS_MTP_PASSWORD do not exists"
    return_code=1;
  fi
  if [[ -z "${AWS_MTP_SERVICE_NAME}" ]]; then
    echo "The required environment variable AWS_MTP_SERVICE_NAME do not exists"
    return_code=1;
  fi
  if [[ -z "${AWS_MTP_SOURCE_SCHEMA}" ]]; then
    echo "The required environment variable AWS_MTP_SOURCE_SCHEMA do not exists"
    return_code=1;
  fi
  return $return_code;
}

function check_environment_variables() {
    check_aws_ps_environment_variables
    ps_variables=$?
    check_aws_mtp_environment_variables
    mtp_variables=$?
    if [[ $ps_variables != 0 || $mtp_variables != 0 ]]; then
        exit 1
    fi
}