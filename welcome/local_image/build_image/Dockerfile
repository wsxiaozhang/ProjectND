# Airfield app

# set REDIS_HOST and REDIS_PORT to your local settings

FROM 9.181.27.216/javabaseimage
MAINTAINER HaiRui Zhang, Kai Zhang
add ./alternative.sources.list /etc/apt/alternative.sources.list
run cat /etc/apt/alternative.sources.list > /etc/apt/sources.list
run rm /etc/apt/alternative.sources.list
run apt-get update
run apt-get install -y maven2
run update-alternatives --set java /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java

run sed -i 's#<localRepository>/path/to/local/repo</localRepository>#--><localRepository>/work_dir/.m2/repository</localRepository><!--#g' /etc/maven2/settings.xml
cmd ["/bin/bash", "/work_dir/build_app"]
