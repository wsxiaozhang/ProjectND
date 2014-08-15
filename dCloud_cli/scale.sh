#! /bin/bash 

if [ "$#" -lt 2 ]; then
  echo "$0 app_name instance"
  exit 1
fi
base_dir=$(cd "$(dirname "$0")"; pwd)
source "${base_dir}/de.properties"
marathon_api="$marathon_api"
docker_host="$docker_host"
docker_port="$docker_port"
app_name="$1"
instances="$2"
version="$3"
#MANIFEST_TEMPLATE="{\"container\":{\"image\":\"docker:///${docker_host}:${docker_port}/$image_name\"},\"id\":\"$app_name\",\"instances\":\"$instances\"}"
MANIFEST_TEMPLATE="{\"id\":\"$app_name\",\"instances\":\"$instances\"}"

curl -X PUT -H "Content-Type: application/json" $marathon_api/v2/apps/$app_name -d "$MANIFEST_TEMPLATE"


