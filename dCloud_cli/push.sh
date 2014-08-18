#! /bin/bash 

if [ "$#" -lt 3 ]; then
  echo "$0 app_name image_name instance"
  exit 1
fi
base_dir=$(cd "$(dirname "$0")"; pwd)
source "${base_dir}/de.properties"
marathon_api="$marathon_api"
docker_host="$docker_host"
docker_port="$docker_port"
app_name="$1"
image_name="$2"
instances="$3"
version="$4"
MANIFEST_TEMPLATE="{\"container\":{\"image\":\"docker:///${docker_host}:${docker_port}/$image_name\"},\"id\":\"$app_name\",\"cpus\":\"1\",\"mem\":\"512\",\"instances\":\"$instances\"}"
#MANIFEST_TEMPLATE="{\"container\":{\"image\":\"docker:///${docker_host}:${docker_port}/$image_name\"},\"id\":\"$app_name\",\"instances\":\"$instances\"}"

curl -s -X POST -H "Content-Type: application/json" $marathon_api/v2/apps -d "$MANIFEST_TEMPLATE"


