FROM owcs/1-base-weblogic:latest
USER root
WORKDIR /
RUN java -jar downloader.jar sources.link=sites.zip
WORKDIR /app
RUN jar xvf /sites.zip.zip
USER app
COPY oraInst.loc sites.rsp /app/
RUN java -jar *.jar -responseFile /app/sites.rsp -silent -invPtrLoc /app/oraInst.loc -ignoreSysPrereqs -force -novalidation ; rm *.jar
