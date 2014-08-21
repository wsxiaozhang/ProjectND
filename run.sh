#! /bin/bash

if [ "$#" -eq "0" ]; then
  echo "you can use: $0 port port ... to set port mapping from host to application" 
  echo "for example: $0 8080 8888:8088"
fi
base_dir="$(cd "$(dirname "$0")"; pwd)"
#project_name="$1"
#shift
#base_image="${project_name}_run_image"
run_cache=${base_dir}/.tmp_run
if [ -f "$run_cache" ];then
  base_image=`cat $run_cache`
fi
 
if [ "$base_image" == "" ]; then
  base_image=`date +%N`
  echo "$base_image" > $run_cache
fi
work_dir=${base_dir}/work_dir
ports="$*"
ports_arr=("$ports")
ports_str=" "
for port in $ports_arr 
do 
  ports_str="$ports_str -p $port "
done
docker build --force-rm=true -t "$base_image" $base_dir/local_image/run_image
if [ "$?" == "0" ]; then
  docker rm -f "${base_image}_container" > /dev/null 2>&1
  docker run --name="${base_image}_container" -d -v $work_dir:/work_dir $ports_str  $base_image  "/bin/bash" "/work_dir/run_app"
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
