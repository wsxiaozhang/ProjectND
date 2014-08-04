#! /bin/bash

if [ "$#" -lt "2" ]; then
  echo "$0 image_name work_dir"
  exit 1
fi

base_image=$1
work_dir=$2

docker run  -i  -v $work_dir:/work_dir  $1  "/bin/bash" "/work_dir/build_app"

