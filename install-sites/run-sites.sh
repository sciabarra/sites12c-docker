#!/bin/bash
sed -i s/$(cat host.txt)/sites/ weblogic/user_projects/domains/base_domain/wcsites/wcsites/config/jbossTicketCacheReplicationConfig.xml
ln -sf /app/weblogic/user_projects/domains/base_domain/servers/wcsites_server1/logs /app/logs
if test -e /tmp/weblogic-running
then
 weblogic/user_projects/domains/base_domain/bin/stopManagedWebLogic.sh wcsites_server1 
else
 if ping -c 1 shared.loc 
 then
   while ! nc shared.loc 1521 </dev/null 2>/dev/null
   do sleep 1 ; echo waiting for database
   done
   echo wait 15 sec
   sleep 5
   echo wait 10 sec
   sleep 5
   echo wait 5 sec
   sleep 5
 fi
 touch /tmp/weblogic-running
fi
echo "starting weblogic"
weblogic/user_projects/domains/base_domain/bin/startManagedWebLogic.sh wcsites_server1 &
