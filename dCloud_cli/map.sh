#! /bin/bash

if [ "$#" -lt 2 ]; then
  echo "$0 router app"
  exit 1
fi
base_dir=$(cd "$(dirname "$0")"; pwd)
source  "${base_dir}/de.properties"
host="$1"
app="$2"
etcd_server="$etc_peers"
marathon_api="$marathon_api"
etcdctl="$base_dir/etcdctl"
if curl -s -X GET -H 'Content-Type: application/json' http://9.115.210.55:8080/v2/apps/$app | grep -q "does not exist"
then
  echo "haven't created app $app yet!"
  exit 1
fi
$etcdctl --peers $etcd_server ls /vulcand/hosts/$host/
if [ $? -eq 0 ]; then
  $etcdctl --peers $etcd_server setdir /vulcand/hosts/$host/apps/$app
  if [ $? -eq 0 ]; then
    echo "succeed to bind app $app to host $host"
    exit 0
  else
    echo "failed to bind app $app to host $host"
    exit 1
  fi
else
  echo "host $host doesn't exist!"
  exit 1
fi

