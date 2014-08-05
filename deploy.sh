#! /bin/bash

if [ "$#" -lt "3" ]; then
  echo "$0 image_name work_dir ports" 
  echo "for example: $0 buildimage ./work_dir \"8080 8888:8088\""
  exit 1
fi
base_dir="$(cd "$(dirname "$0")"; pwd)"

base_image="$1"
work_dir="$2"
ports="$3"
ports_arr=(${ports})
ports_str=" "
for port in $ports_arr 
do 
  ports_str="$ports_str -p $port "
done
docker build -t "$base_image" $base_dir/local_image/deploy_image
docker run  -d  -v $work_dir:/work_dir $ports_str $base_image  "/bin/bash" "/work_dir/run_app"
