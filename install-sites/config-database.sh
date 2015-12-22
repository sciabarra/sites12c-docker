#!/bin/bash

OP=${1:-create}
PASS=${2:-Welcome1}
DB=${3:-shared.loc:1521:XE}
PREFIX=${4:-DEV}
HOST=$(echo $DB | sed -e 's/:.*//')
# wait oracle is available
while ! nc $HOST 1521 </dev/null >/dev/null
do sleep 1 ; echo "." ; done
sleep 5

case $OP in
create)
   # fix for oraclexe
   echo "ALTER SESSION SET CURRENT_SCHEMA=&&1;" >weblogic/oracle_common/common/sql/iau/scripts/prepareAuditView.sql 
   printf "%s\\n%s\\n" "$PASS" "$PASS" | weblogic/oracle_common/bin/rcu -silent \
    -createRepository -connectString "$DB" -dbUser SYS -dbRole SYSDBA \
    -useSamePasswordForAllSchemaUsers true -schemaPrefix "$PREFIX" \
    -component STB -component OPSS \
    -component WCSITES -component WCSITESVS \
    -component IAU -component IAU_APPEND -component IAU_VIEWER 
;;
delete)
   echo $PASS | weblogic/oracle_common/bin/rcu -silent -dropRepository -connectString $DB -dbUser SYS -dbRole SYSDBA -schemaPrefix $PREFIX -component STB -component OPSS -component WCSITES -component WCSITESVS -component IAU -component IAU_APPEND -component IAU_VIEWER 
;;
*) echo "usage: create|delete" ;;
esac
