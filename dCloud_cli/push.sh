#! /bin/bash 

if [ "$#" -lt 3 ]; then
  echo "$0 app_name image_name instance"
  exit 1
fi

base_dir=$(cd "$(dirname "$0")"; pwd)
source "${base_dir}/de.properties"
source "${base_dir}/utils.sh"
#make some init work
init

marathon_api="$marathon_api"
docker_host="$docker_host"
docker_port="$docker_port"
log_file="$log_dir/push_detail.log"

app_name="$1"
image_name="$2"
instances="$3"
version="$4"

MANIFEST_TEMPLATE="{\"container\":{\"image\":\"docker:///$image_name\"},\"id\":\"$app_name\",\"cpus\":\"1\",\"mem\":\"512\",\"instances\":\"$instances\"}"
#MANIFEST_TEMPLATE="{\"container\":{\"image\":\"docker:///${docker_host}:${docker_port}/$image_name\"},\"id\":\"$app_name\",\"instances\":\"$instances\"}"

status_code=`curl -o /dev/null -s -X POST -H "Content-Type: application/json" -w %{http_code} $marathon_api/v2/apps -d "$MANIFEST_TEMPLATE"`
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
  succeed "succeed to push app $app_name"
  exit 0
else
  error "failed to create app $app_name, and status_code is $status_code"
  exit 1
fi


