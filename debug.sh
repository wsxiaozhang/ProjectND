#! /bin/bash
base_dir="$(cd "$(dirname "$0")"; pwd)"
work_dir=$base_dir/work_dir

docker build --rm -t debugjavaimage $base_dir/local_image/debug_image 
docker run -it --rm -v $work_dir:/work_dir -p 7777:7777 debugjavaimage

echo "debug server exited"

