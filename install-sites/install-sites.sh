#!/bin/bash
# wait database
while ! nc shared.loc 1521 </dev/null 2>/dev/null
do sleep 1 ; echo waiting for database
done
echo wait 15 sec
sleep 5
echo wait 10 sec
sleep 5
echo wait 5 sec
sleep 5
# configure sites
bash bootstrap-sites.sh "$(cat host.txt)" 7003 "$(cat db.txt)" "$(cat password.txt)"
bash config-sites.sh
bash http-sites.sh
# fix sites afterwards
sed -i s/$(cat host.txt)/sites.loc/ \
  weblogic/user_projects/domains/base_domain/wcsites/wcsites/config/jbossTicketCacheReplicationConfig.xml
rm -f password.txt
