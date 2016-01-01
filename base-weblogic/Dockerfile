FROM owcs/1-base-java:latest
RUN java -jar downloader.jar sources.link=weblogic.zip
WORKDIR /app
RUN jar xvf /weblogic.zip.zip ; rm /*.zip ; chown app:app *.jar 
USER app
COPY oraInst.loc weblogic.rsp /app/
RUN java -jar *.jar -responseFile /app/weblogic.rsp -silent -invPtrLoc /app/oraInst.loc ; rm *.jar
