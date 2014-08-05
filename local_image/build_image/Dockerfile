# Airfield app

# set REDIS_HOST and REDIS_PORT to your local settings

FROM javabaseimage
MAINTAINER Nick Stinemates, Thatcher Peskens
run apt-get update
run apt-get install -y maven2

run sed -i 's#<localRepository>/path/to/local/repo</localRepository>#--><localRepository>/work_dir/.m2/repository</localRepository><!--#g' /etc/maven2/settings.xml
cmd ["/bin/bash", "/work_dir/build_app"]
