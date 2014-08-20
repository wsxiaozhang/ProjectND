#! /bin/bash 

if [ "$#" -lt "2" ]; then
  echo "you can use: $0 app_name image_name host" 
  exit 1
fi
base_dir="$(cd "$(dirname "$0")"; pwd)"
app_name="$1"
image_name="$2"
host="$3"

if $base_dir/dCloud_cli/delete_app.sh "$app_name" > /dev/null 2>&1; then
  $base_dir/dCloud_cli/delete_router.sh "$host" > /dev/null 2>&1
  if $base_dir/dCloud_cli/push.sh "$app_name" "${image_name}" "1"; then
    echo "succeed to push app $app_name"
    if $base_dir/dCloud_cli/create_router.sh "$host"; then
      echo "succeed to create host $host"
      if $base_dir/dCloud_cli/map.sh "$host" "$app_name"; then
        echo "succeed to map app $app_name to host $host"
      else
        echo "failed to map app $app_name to host $host"
        exit 1
      fi 
    else
      echo "failed to create host $host"
      exit 1
    fi
  else
    echo "failed to push app $app_name"
    exit 1
  fi
else
  echo "faild to delete old project "$app_name" you deployed before"
  exit 1
fi
