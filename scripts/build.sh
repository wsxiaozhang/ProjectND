#! /bin/bash

if [ "$#" -lt "1" ]; then
  echo "$0 dependency_file"
  exit 1
fi
dependency_file="$1"
base_dir="$(cd "$(dirname "$0")"; pwd)"

function build_project(){
  p_name="$1"
  image_name="${p_name}_build"
  image_dir="$base_dir/../$p_name/local_image/build_image"
  work_dir="$base_dir/../$p_name"
  if [ -d "$work_dir" ]; then
    cache_dir="$base_dir/cache"
    mkdir -p $cache_dir
      docker build --force-rm=true -t "$image_name"  $image_dir
    if [ "$?" == "0" ]; then
      docker run --rm=true -v $work_dir:/work_dir -v $cache_dir:/build_cache  $image_name "/bin/bash" "/work_dir/build_app"
      if [ "$?" == "0" ]; then
        echo "run image successfully!"
      else
        echo "run image failed!!"
        exit 1
      fi
    else
      echo "build image failed!!"
      exit 1
    fi
  else
    echo "Project $p_name does not exist!!!"
    exit 1
  fi

}
if [ -f "$dependency_file" ]; then
#dependency_file="$base_dir/${project_name}.dependency"
# build the dependent project
  for p_name in `cat "$dependency_file"`
  do
   build_project "$p_name"
  done
else
  echo "dependency does not exist!!! Please provide it"
fi
