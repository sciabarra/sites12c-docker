#!/bin/bash
echo "****" Starting weblogic
weblogic/user_projects/domains/base_domain/startWebLogic.sh 2>&1 >/app/admin.log &
tail -f admin.log | sed /RUNNING/q
#while ! nc admin 7001 </dev/null 2>/dev/null; do sleep 1 ; tail ; done
echo "****" Granting Permissions
weblogic/user_projects/domains/base_domain/wcsites/bin/grant-opss-permission.sh weblogic Welcome1
cp wcs_properties_bootstrap.ini weblogic/user_projects/domains/base_domain/wcsites/wcsites/config/wcs_properties_bootstrap.ini
echo "****" Starting managed Sites
weblogic/user_projects/domains/base_domain/bin/startManagedWebLogic.sh wcsites_server1 t3://admin:7001 2>&1 >/app/managed.log &
tail -f managed.log | sed /RUNNING/q
#while ! nc admin 7003 </dev/null ; do sleep 1 ; tail managedweblogic.log ; done

