#! /bin/bash

if [ "$#" -lt "1" ]; then
  echo "usage: $0 project_name port1 port2 ..."
  echo "port1 and port2 can be ip:port:port, port:port, port"
  exit 1
fi
base_dir="$(cd "$(dirname "$0")"; pwd)"

project_name="$1"

shift
work_dir=$base_dir/../$project_name
# get all the ports
ports="$*"
ports_arr=("$ports")
ports_str=" "
for port in $ports_arr
do
  ports_str="$ports_str -p $port "
done

debug_image="${project_name}_debug_image"

if docker build --rm -t "$debug_image" $work_dir/local_image/debug_image; then
  docker run -it --rm -v $work_dir:/work_dir $ports_str "$debug_image" "/bin/bash" "/work_dir/debug_app"
  echo "exit from debug mode"
else
  echo "failed to build debug image"
  exit 1
fi
