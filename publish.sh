#! /bin/bash

if [ "$#" -lt "2" ]; then
  echo "you can use: $0 project_name image_name" 
  exit 1
fi
base_dir="$(cd "$(dirname "$0")"; pwd)"
project_name="$1"
base_image="${project_name}_publish_image"
target_image="$2"
 
work_dir="${base_dir}/work_dir"
image_dir="$base_dir/local_image/deploy_image"
image_work_dir="$image_dir"/work_dir
mkdir "$image_work_dir"
cp -r $work_dir/$project_name $work_dir/run_app "$image_work_dir"/ > /dev/null
docker build --force-rm=true -t "$base_image" "$image_dir"
if [ "$?" == "0" ]; then
  rm -rf "$image_work_dir"
  $base_dir/dCloud_cli/publish_image.sh $base_image $target_image
else
  rm -rf "$image_work_dir"
  echo "build image failed!!"
  exit 1
fi
