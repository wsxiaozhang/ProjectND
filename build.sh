#! /bin/bash

#if [ "$#" -lt "1" ]; then
#  echo "$0 image_name"
#  exit 1
#fi
base_dir="$(cd "$(dirname "$0")"; pwd)"
base_image=""
work_dir=${base_dir}/work_dir
build_cache=${base_dir}/.tmp_build
if [ -f "$build_cache" ];then
  base_image=`cat $build_cache`
fi
 
if [ "$base_image" == "" ]; then
  base_image=`date +%N`
  echo "$base_image" > $build_cache
fi
docker build --force-rm=true -t "$base_image"  $base_dir/local_image/build_image
if [ "$?" == "0" ]; then
  docker run --rm=true -v $work_dir:/work_dir  $base_image  "/bin/bash" "/work_dir/build_app"
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
