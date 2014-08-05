# Airfield app

# set REDIS_HOST and REDIS_PORT to your local settings

FROM 9.181.27.216/javabaseimage
MAINTAINER HaiRui Zhang, Kai Zhang
run apt-get update
run apt-get install -y maven2

run sed -i 's#<localRepository>/path/to/local/repo</localRepository>#--><localRepository>/build_cache/.m2/repository</localRepository><!--#g' /etc/maven2/settings.xml
cmd ["/bin/bash", "/work_dir/build_app"]
