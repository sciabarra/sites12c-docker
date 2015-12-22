BASE1=${1:?where the files are in http}
BASE=${BASE1%/}
eval $(bash _machine.sh)
echo >base-java/jdk.rpm.link \
 $BASE/jdk-8u66-linux-x64.rpm
echo >base-oracle/oraclexe.rpm.link \
 $BASE/oracle-xe-11.2.0-1.0.x86_64.rpm
echo >base-weblogic/weblogic.jar.link \
 $BASE/fmw_12.2.1.0.0_infrastructure.jar
echo >base-sites/sites.jar.link \
 $BASE/fmw_12.2.1.0.0_wcsites_generic.jar
for i in base-java base-oracle base-weblogic base-sites 
do echo ============  docker build -t owcs/$i:latest $i
sleep 3
docker build -t owcs/$i:latest $i
done
