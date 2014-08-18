#! /bin/bash
base_dir="$(cd "$(dirname "$0")"; pwd)"
work_dir=$base_dir/work_dir

docker build --rm -t debugtomcatimage $base_dir/local_image/debug_web_image
docker run -it --rm -v $work_dir:/work_dir -p 8888:8080  -p 7778:8078 debugtomcatimage

echo "debug Web server - tomcat 7 exited"

