#! /bin/bash

if [ "$#" -eq "0" ]; then
  echo "usage: $0 port1 port2 ..."
  echo "port1 and port2 can be ip:port:port, port:port, port"
fi
base_dir="$(cd "$(dirname "$0")"; pwd)"
debug_cache=${base_dir}/.tmp_debug
if [ -f "$debug_cache" ];then
  base_image=`cat $debug_cache`
fi
 
if [ "$base_image" == "" ]; then
  base_image=`date +%N`
  echo "$base_image" > $debug_cache
fi
work_dir=$base_dir/work_dir

#project_name="$1"
#shift
# get all the ports
ports="$*"
ports_arr=(${ports})
ports_str=" "
for port in $ports_arr
do
  ports_str="$ports_str -p $port "
done

debug_image="${base_image}"

if docker build --rm -t "$debug_image" $base_dir/local_image/debug_web_image; then
  docker run -it --rm -v $work_dir:/work_dir $ports_str "$debug_image"
  echo "exit from debug mode"
else
  echo "failed to build debug image"
  exit 1
fi
