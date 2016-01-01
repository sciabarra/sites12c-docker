FROM oraclelinux:7
RUN yum -y update && yum clean all && yum -y install sudo telnet less nc perl wget
RUN groupadd -g 2000 app && \
    useradd -g 2000 -u 2000 -d /app app && \
    echo "app ALL=(ALL) ALL" >>/etc/sudoers && \
    echo "app:app" | chpasswd
RUN wget --progress=dot:giga --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u66-b17/jdk-8u66-linux-x64.rpm -Ojdk.rpm
RUN rpm -ivh jdk.rpm && rm jdk.rpm
COPY downloader.jar .
COPY sources.link .
