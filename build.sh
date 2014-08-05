#! /bin/bash

if [ "$#" -lt "1" ]; then
  echo "$0 image_name"
  exit 1
fi
base_dir="$(cd "$(dirname "$0")"; pwd)"
base_image=$1
work_dir=${base_dir}/work_dir
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
