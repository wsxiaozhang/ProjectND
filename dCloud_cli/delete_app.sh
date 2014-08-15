#! /bin/bash

if [ "$#" -lt 1 ]; then
  echo "$0 app_name"
  exit 1
fi
base_dir=$(cd "$(dirname "$0")"; pwd)
source "${base_dir}/de.properties"
marathon_api="$marathon_api"
docker_host="$docker_host"
docker_port="$docker_port"
app_name="$1"

curl -s -X DELETE -H "Content-Type: application/json" $marathon_api/v2/apps/$app_name


