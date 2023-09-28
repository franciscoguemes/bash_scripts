#!/usr/bin/env bash


function get_all_running_instances {
  local -r url=$1
  local output=$(curl --silent --fail-with-body "$url")
  if [[ "$?" -ne 0 ]]; then
    echo "ERROR: $output"
    retun 1
  fi
  echo "$output"
}


function get_ips_from_old_cluster_instances {
  local -r json="$1"
  local -r cluster_name="$2"
  local output=$(echo "$json" | jq --arg cn "$cluster_name" -r '.data.result[] | select(.metric.cluster == $cn) | .metric.ip')
  echo "$output"
}

function build_filters_as_json {
  local -r ip_array=$1
  local -r az_array=$2
  local -r filters=$( jq -n \
      --arg ip_filter "network-interface.addresses.private-ip-address" \
      --argjson ip "$ip_array" \
      --arg az_filter "availability-zone" \
      --argjson az "$az_array" \
      '[{Name:$ip_filter,Values:$ip},{Name:$az_filter,Values:$az}]' )
  echo "$filters"
}

