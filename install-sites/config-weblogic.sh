#!/bin/bash

DB=${1:-shared.loc:1521:XE}
PASS=${2:-Welcome1}
PREFIX=${3:-DEV}

weblogic/oracle_common/common/bin/wlst.sh config-weblogic.py jdbc:oracle:thin:@$DB "$PASS" "$PREFIX"

sed -i.bak -e 's/WLS_USER=""/WLS_USER="weblogic"/' -e 's/WLS_PW=""/WLS_PW="'$PASS'"/' -e 's!JAVA_OPTIONS="-Dweblogic!JAVA_OPTIONS="-Djava.security.egd=file:///dev/urandom -Djava.net.preferIPv4Stack=true -Dweblogic!' weblogic/user_projects/domains/base_domain/bin/startManagedWebLogic.sh
