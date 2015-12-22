#!/bin/bash
USER=${1:-weblogic}
PASS=${2:-Welcome1}
echo "****" Starting weblogic
weblogic/user_projects/domains/base_domain/startWebLogic.sh 2>&1 >/app/admin.log &
tail -f admin.log | sed /RUNNING/q
echo "****" Granting Permissions
weblogic/user_projects/domains/base_domain/wcsites/bin/grant-opss-permission.sh "$USER" "$PASS"
cp wcs_properties_bootstrap.ini weblogic/user_projects/domains/base_domain/wcsites/wcsites/config/wcs_properties_bootstrap.ini
sed -i s/$(cat host.txt)/sites/ weblogic/user_projects/domains/base_domain/wcsites/wcsites/config/jbossTicketCacheReplicationConfig.xml
echo "****" Starting managed Sites
weblogic/user_projects/domains/base_domain/bin/startManagedWebLogic.sh wcsites_server1 t3://sites:7001 2>&1 >/app/managed.log &
tail -f managed.log | sed /RUNNING/q
curl http://$(cat host.txt):7003/sites/HelloCS
curl http://$(cat host.txt):7003/sites/sitesconfig 
