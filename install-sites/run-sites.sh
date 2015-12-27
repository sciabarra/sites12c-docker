#!/bin/bash
sed -i s/$(cat host.txt)/sites/ weblogic/user_projects/domains/base_domain/wcsites/wcsites/config/jbossTicketCacheReplicationConfig.xml
while ! nc shared.loc 1521 </dev/null 2>/dev/null
do sleep 1 ; echo waiting for database
done
echo wait 10 sec
sleep 5
echo wait 5 sec
sleep 5
echo "starting weblogic"
weblogic/user_projects/domains/base_domain/bin/startManagedWebLogic.sh wcsites_server1
