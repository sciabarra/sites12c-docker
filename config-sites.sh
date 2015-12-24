#!/bin/bash
USER=${1:-weblogic}
PASS=${2:-Welcome1}
echo "****" Starting weblogic
weblogic/user_projects/domains/base_domain/startWebLogic.sh 2>&1 >/app/admin.log &
perl tailuntil.pl RUNNING admin.log
echo "****" Granting Permissions
weblogic/user_projects/domains/base_domain/wcsites/bin/grant-opss-permission.sh "$USER" "$PASS"
cp wcs_properties_bootstrap.ini weblogic/user_projects/domains/base_domain/wcsites/wcsites/config/wcs_properties_bootstrap.ini
echo "****" Starting managed Sites
sed -i s/$(cat host.txt)/sites/ weblogic/user_projects/domains/base_domain/wcsites/wcsites/config/jbossTicketCacheReplicationConfig.xml
weblogic/user_projects/domains/base_domain/bin/startManagedWebLogic.sh wcsites_server1 t3://sites:7001 2>&1 >/app/managed.log &
perl tailuntil.pl RUNNING managed.log
echo "****" Completing install
curl http://$(cat host.txt):7003/sites/HelloCS
curl http://$(cat host.txt):7003/sites/sitesconfig 
sed -i s/$(cat host.txt)/sites/ weblogic/user_projects/domains/base_domain/wcsites/wcsites/config/jbossTicketCacheReplicationConfig.xml
