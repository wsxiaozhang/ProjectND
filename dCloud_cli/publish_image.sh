#! /bin/bash 

if [ "$#" -lt 2 ]; then
  echo "$0 source_image_name publish_image_name"
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
log_file="$log_dir/publish_detail.log"
source_image_name="$1"
publish_image_name="$2"

docker tag "${source_image_name}" "${publish_image_name}" >> "$log_file" 2>&1
if [ "$?" != "0" ]; then
  error "failed to change tag ${source_image_name} to $docker_host/"${publish_image_name}""
  exit 1
else
  docker push "${publish_image_name}" >> "$log_file" 2>&1
  if [ "$?" != "0" ]; then
    error "failed to push $docker_host/"${publish_image_name}" to registry"
    exit 1
  else
    succeed "succeed to push $docker_host/"${publish_image_name}" to registry"
    exit 0
  fi
fi
