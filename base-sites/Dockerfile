FROM owcs/base-weblogic:latest
USER app
WORKDIR /app
ADD oraInst.loc /app/oraInst.loc
COPY sites.rsp sites.jar.link /app/
RUN curl >sites.jar $(cat sites.jar.link) 
RUN java -jar sites.jar -responseFile /app/sites.rsp -silent -invPtrLoc /app/oraInst.loc ; rm sites.jar
