#! /bin/bash 

if [ "$#" -lt 2 ]; then
  echo "$0 app_name instance"
  exit 1
fi

base_dir=$(cd "$(dirname "$0")"; pwd)
source "${base_dir}/de.properties"
source "${base_dir}/utils.sh"
# make some init work
init

marathon_api="$marathon_api"
docker_host="$docker_host"
docker_port="$docker_port"
log_file="${log_dir}/scale.log"

app_name="$1"
instances="$2"
version="$3"

MANIFEST_TEMPLATE="{\"id\":\"$app_name\",\"instances\":\"$instances\"}"

status_code=`curl -o /dev/null -X PUT -H "Content-Type: application/json" -w %{http_code} $marathon_api/v2/apps/$app_name -d "$MANIFEST_TEMPLATE" 2>/dev/null`
running_instances=0

wait_times=0
if [ "$status_code" -ge "200" -a "$status_code" -lt "300" ]; then
  while [ "$running_instances" -ne "$instances" ]
  do
    if [ "$wait_times" -gt "6" ]; then
      warning "instances running: $running_instances/$instances , please check it on ui!"
      exit 0
    fi
    running_instances=`curl -s -X GET -H "Content-Type: application/json" $marathon_api/v2/apps/$app_name | ruby -rjson -e "puts JSON[STDIN.read]['app']['tasksRunning'];"`
    info "check instances running: $running_instances/$instances, you can ctrl-c to stop waiting!"
    sleep 5
    wait_times=$(($wait_times + 1))
  done
  succeed "succeed to scale app $app_name"
  exit 0
else
  error "failed to scale app $app_name, and status_code is $status_code"
  exit 1
fi
