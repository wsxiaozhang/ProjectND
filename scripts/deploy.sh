#! /bin/bash

if [ "$#" -lt "2" ]; then
  echo "you can use: $0 project_name \"port port\" to set port mapping from host to container" 
  echo "for example: $0 helloworld  \"8080 8888:8088 127.0.0.1:8080:8080\" "
fi
base_dir="$(cd "$(dirname "$0")"; pwd)"

p_name="$1"

image_name="${p_name}_deploy"
image_dir="$base_dir/../$p_name/local_image/deploy_image"
work_dir="$base_dir/../$p_name"
ports="$2"
ports_arr=(${ports})
ports_str=" "
for port in $ports_arr 
do 
  ports_str="$ports_str -p $port "
done
docker build --force-rm=true -t "$image_name" $image_dir
if [ "$?" == "0" ]; then
#  docker rm -f "${base_image}_container"
  docker run --name="${image_name}_container" -d -v $work_dir:/work_dir/$p_name $ports_str  $image_name  "/bin/bash" "/work_dir/$p_name/run_app"
  if [ "$?" == "0" ]; then
    echo "run image successfully!"
    exit 0
  else
    echo "run image failed!!"
    exit 1
  fi
else
  echo "build image failed!!"
  exit 1
fi
