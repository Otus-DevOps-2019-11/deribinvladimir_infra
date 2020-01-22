#!/bin/bash

app_ip=`cd ../terraform/stage && terraform output | grep app_external_ip | awk '{print $3}'`
db_ip=`cd ../terraform/stage && terraform output | grep db_external_ip | awk '{print $3}'`

if [ "$1" == "--list" ] ; then
  echo '{"app": {"hosts": ["34.89.145.106"]}, "db": {"hosts": ["34.89.200.4"]}}'
#cat<<EOF
#{"app": {"hosts": ["$app_ip"]}, "db": {"hosts": ["$db_ip"]}}
#EOF
elif [ "$1" == "--host" ]; then
  echo '{"_meta": {"hostvars": {}}}'
else
  echo "{ }"
fi
