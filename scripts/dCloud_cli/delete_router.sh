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
router="${host}.${domain}"
vulcan_api="$vulcan_api"
log_file="${log_dir}/delete_router.log"

status_code=`curl -o /dev/null -s -X DELETE -H "Content-Type: application/json" -w %{http_code} $vulcan_api/v1/hosts/$router`

if [ "$status_code" -ge "200" -a "$status_code" -lt "300" ]; then
  succeed "succeed to delete host $host"
  exit 0
else
  error "failed to delete host $host, and status_code is $status_code"
  exit 1
fi

