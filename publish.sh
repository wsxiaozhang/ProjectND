#! /bin/bash

if [ "$#" -lt "2" ]; then
  echo "you can use: $0 project_name host" 
  exit 1
fi
base_dir="$(cd "$(dirname "$0")"; pwd)"
project_name="$1"
host="$2"
base_image="${project_name}_image"
 
work_dir="${base_dir}/work_dir"
image_dir="$base_dir/local_image/publish_image"
image_work_dir="$image_dir"/work_dir
mkdir "$image_work_dir"
cp -r $work_dir/$project_name $work_dir/run_app "$image_work_dir"/ > /dev/null
docker build --force-rm=true -t "$base_image" "$image_dir"
if [ "$?" == "0" ]; then
  rm -rf "$image_work_dir"
  docker tag "${project_name}_image" 9.181.27.216/"${project_name}_image"
  docker push 9.181.27.216/"${project_name}_image"
  $base_dir/dCloud_cli/delete_app.sh "$project_name"
  $base_dir/dCloud_cli/delete_router.sh "$host"
  $base_dir/dCloud_cli/push.sh "$project_name" "${project_name}_image" "1"
  $base_dir/dCloud_cli/create_router.sh "$host"
  $base_dir/dCloud_cli/map.sh "$host" "$project_name" 
else
  rm -rf "$image_work_dir"
  echo "build image failed!!"
  exit 1
fi
