FROM owcs/base-java:latest
USER app
WORKDIR /app
ADD oraInst.loc /app/oraInst.loc
COPY weblogic.rsp weblogic.jar.link /app/
RUN curl >weblogic.jar $(cat weblogic.jar.link) 
RUN java -jar weblogic.jar -responseFile /app/weblogic.rsp -silent -invPtrLoc /app/oraInst.loc ; rm weblogic.jar
