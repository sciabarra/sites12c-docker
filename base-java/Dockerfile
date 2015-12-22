FROM oraclelinux:7
RUN yum -y update && yum clean all && yum -y install sudo telnet less nc
RUN useradd -d /app app && \
    echo "app ALL=(ALL) ALL" >>/etc/sudoers && \
    echo "app:app" | chpasswd
COPY jdk.rpm.link .
RUN curl $(cat jdk.rpm.link) >jdk.rpm 
RUN rpm -ivh jdk.rpm && rm jdk.rpm
