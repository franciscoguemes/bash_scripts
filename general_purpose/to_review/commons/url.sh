#!/usr/bin/env bash

function get_prometheus_url {
  local -r stage=$1
  local PROMETHEUS_URL=""
  if [[ "${stage}" == "mtp" ]];then
    PROMETHEUS_URL="http://prometheus-baufismart-mtp.shared.ep.aws.it-hps.de/api/v1/query?query=mod_jk_current_cluster"
  elif [[ "${stage}" == "ps" ]];then
    PROMETHEUS_URL="http://prometheus-baufismart.shared.ep.aws.it-hps.de/api/v1/query?query=mod_jk_current_cluster"
  else
    echo "ERROR: The given ${stage} does not exits"
    return 1
  fi
  echo "$PROMETHEUS_URL"
}

function get_application_version_service_url {
  local -r stage=$1
  local APPLICATION_VERSION_SERVICE_URL=""
  if [[ "${stage}" == "mtp" ]];then
    APPLICATION_VERSION_SERVICE_URL="https://ep2-core-application-versions-service.eks.mtp.bs.ep.aws.it-hps.de/cluster/old_first"
  elif [[ "${stage}" == "ps" ]];then
    APPLICATION_VERSION_SERVICE_URL="https://ep2-core-application-versions-service.eks.ps.bs.ep.aws.it-hps.de/cluster/old_first"
  else
    echo "ERROR: The given ${stage} does not exits"
    return 1
  fi
  echo "$APPLICATION_VERSION_SERVICE_URL"
}



function test_connection {
    local -r url=$1
    local response_code=$(curl -s -o /dev/null -w "%{http_code}" "$url")
    if [[ $response_code -ne 200 ]]; then
        echo "ERROR: HTTP response code is $response_code"
        if [[ $response_code -eq 0 ]]; then
          echo "ERROR: First you need to login in AWS and select a profile/account"
        fi
    fi
}