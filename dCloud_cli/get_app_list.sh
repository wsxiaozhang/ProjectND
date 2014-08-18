#! /bin/bash

base_dir=$(cd "$(dirname "$0")"; pwd)
source "$base_dir/de.properties"

marathon_api="$marathon_api"

result=`curl -X GET -H "Content-Type: application/json" -s $marathon_api/v2/apps`
length=$(echo $result | ruby -rjson -e "puts JSON[STDIN.read]['apps'].length;")
echo "------------------------"
printf '|%10s | %9s|\n' "app_name" "instances"
for i in $(seq $length)
do
  app_name="$(echo $result | ruby -rjson -e "puts JSON[STDIN.read]['apps'][$i - 1]['id'];")"
  app_instance="$(echo $result | ruby -rjson -e "puts JSON[STDIN.read]['apps'][$i - 1]['instances'];")"
echo "------------------------"
  printf '|%10s | %9s|\n' "$app_name" "$app_instance"
done
echo "------------------------"
