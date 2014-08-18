# Image of Tomcat7 for run Java Web application

FROM 9.181.27.216/javabaseimage
MAINTAINER HaiRui Zhang, Kai Zhang
run apt-get update
run apt-get install -y wget
run mkdir /tomcat
run wget -O - http://mirrors.cnnic.cn/apache/tomcat/tomcat-7/v7.0.55/bin/apache-tomcat-7.0.55.tar.gz | tar -C /tomcat --strip-components=1 -zxv
