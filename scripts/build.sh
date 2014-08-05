#! /bin/bash

#if [ "$#" -lt "1" ]; then
#  echo "$0 image_name"
#  exit 1
#fi
base_dir="$(cd "$(dirname "$0")"; pwd)"
dependency_file="$base_dir/build.dependency"
for p_name in `cat "$dependency_file"`
do
  image_name="${p_name}_build"
  image_dir="$base_dir/../$p_name/local_image/build_image"
  work_dir="$base_dir/../$p_name"
  cache_dir="$base_dir/cache"
  mkdir -p $cache_dir
    docker build --force-rm=true -t "$image_name"  $image_dir
  if [ "$?" == "0" ]; then
    docker run --rm=true -v $work_dir:/work_dir/$p_name -v $cache_dir:/work_dir/cache  $image_name  "/bin/bash" "/work_dir/$p_name/build_app"
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
done
