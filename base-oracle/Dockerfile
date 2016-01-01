FROM owcs/1-base-java
RUN yum -y update && yum clean all
RUN yum install -y libaio bc net-tools less telnet unzip
RUN java -jar downloader.jar sources.link=oraclexe.zip
RUN unzip oraclexe.zip ; rm oraclexe.zip ; rpm -Uvh Disk1/*.rpm ; rm -Rvf Disk1

# Environment variables 
# -------------------------------------------------------------
ENV TERM xterm

# File needed by oracle-xe silent installation
ADD xe.rsp /tmp/xe.rsp

# Add oracle environment variables
ADD oraenv.sh /etc/profile.d/oraenv.sh

# Work around sysctl limitation of docker
RUN sed -i -e 's/^\(memory_target=.*\)/#\1/' /u01/app/oracle/product/11.2.0/xe/config/scripts/initXETemp.ora \
    && sed -i -e 's/^\(memory_target=.*\)/#\1/' /u01/app/oracle/product/11.2.0/xe/config/scripts/init.ora \
    && /etc/init.d/oracle-xe configure responseFile=/tmp/xe.rsp

# Change hostname in listener.ora e tnsnames.ora
RUN sed -i -E "s/HOST = [^)]+/HOST = 0.0.0.0/g" /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora
RUN sed -i -E "s/HOST = [^)]+/HOST = 0.0.0.0/g" /u01/app/oracle/product/11.2.0/xe/network/admin/tnsnames.ora

EXPOSE 1521 8080

# Added tail -f /dev/null to keep docker in foreground, giving possibility to use docker run -d
CMD /etc/init.d/oracle-xe start; tail -f /dev/null
