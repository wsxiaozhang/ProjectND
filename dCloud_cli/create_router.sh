#! /bin/bash

if [ $# -lt 1 ]; then
  echo "$0 host"
  exit 1
fi

base_dir=$(cd "$(dirname "$0")"; pwd)

source "${base_dir}/de.properties"
host=$1
vulcan_api="$vulcan_api"
host_info="{\"name\":\"$host\"}"

curl -s -X POST -H "Content-Type: application/json" $vulcan_api/v1/hosts -d "$host_info"
