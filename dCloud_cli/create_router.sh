#! /bin/bash

if [ $# -lt 1 ]; then
  echo "$0 host"
  exit 1
fi

base_dir=$(cd "$(dirname "$0")"; pwd)
source "${base_dir}/de.properties"
source "${base_dir}/utils.sh"
# make some init work
init

host=$1
vulcan_api="$vulcan_api"
router="${host}.${domain}"
host_info="{\"name\":\"$router\"}"
log_file="${log_dir}/create_router.log"

status_code=`curl -o /dev/null -s -X POST -H "Content-Type: application/json" -w %{http_code} $vulcan_api/v1/hosts -d "$host_info"`

if [ "$status_code" -ge "200" -a "$status_code" -lt "300" ]; then
  succeed "succeed to create router $router"
  exit 0
else
  error "failed to create router $router, and status_code is $status_code"
  exit 1
fi
