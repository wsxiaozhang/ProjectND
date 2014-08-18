#! /bin/bash

if [ "$#" -lt 2 ]; then
  echo "$0 router app"
  exit 1
fi
host="$1"
app="$2"
etcd_server="http://etcd.bluemix.cdl.ibm.com:4001"
base_dir=$(cd "$(dirname "$0")"; pwd)
etcdctl="$base_dir/etcdctl"


$etcdctl --peers $etcd_server ls /vulcand/hosts/$host/apps/$app
if [ $? -eq 0 ]; then
  $etcdctl --peers $etcd_server rmdir /vulcand/hosts/$host/apps/$app
  if [ $? -eq 0 ]; then
    echo "succeed to unbind app $app to host $host"
  exit 0
  else
    echo "fail to unbind app $app to host $host"
  fi
else
  echo "app $app has not been bind to host $host"
  exit 1  
fi
