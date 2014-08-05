#! /bin/bash

if [ "$#" -lt "2" ]; then
  echo "$0 image_name work_dir"
  exit 1
fi
base_dir="$(cd "$(dirname "$0")"; pwd)"
base_image=$1
work_dir=$2
docker build -t "$base_image"  $base_dir/local_image/buile_image
docker run  -i  -v $work_dir:/work_dir  $base_image  "/bin/bash" "/work_dir/build_app"

