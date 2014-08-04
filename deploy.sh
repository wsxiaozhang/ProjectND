#! /bin/bash

if [ "$#" -lt "3" ]; then
  echo "$0 image_name work_dir ports" 
  echo "for example: $0 buildimage ./work_dir \"8080 8888:8088\""
  exit 1
fi

base_image="$1"
work_dir="$2"
ports="$3"
ports_arr=(${ports})
echo $ports_arr
ports_str=" "
for port in $ports_arr 
do 
  ports_str="$ports_str -p $port "
done
docker run  -d  -v $2:/work_dir $ports_str $1  "/bin/bash" "/work_dir/run_app"
