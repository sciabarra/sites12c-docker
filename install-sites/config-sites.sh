#!/bin/bash
USER=${1:-weblogic}
PASS=${2:-Welcome1}
echo "****" Starting weblogic
touch admin.log
weblogic/user_projects/domains/base_domain/startWebLogic.sh 2>&1 >/app/admin.log &
perl tailuntil.pl RUNNING admin.log
echo "****" Granting Permissions
#if test "$(cat db.txt)" == "HSQLDB"
#then sed -i -e "s/oracle.security.jps.service.credstore.CredentialAccessPermission/java.security.AllPermission/" weblogic/user_projects/domains/base_domain/wcsites/bin/grant-opss-permission.py
#fi
weblogic/user_projects/domains/base_domain/wcsites/bin/grant-opss-permission.sh "$USER" "$PASS"
echo "****" Starting managed Sites
touch managed.log
weblogic/user_projects/domains/base_domain/bin/startManagedWebLogic.sh wcsites_server1 t3://sites:7001 2>&1 >/app/managed.log &
perl tailuntil.pl RUNNING managed.log
