#!/bin/bash
sed -i s/$(cat host.txt)/sites/ weblogic/user_projects/domains/base_domain/wcsites/wcsites/config/jbossTicketCacheReplicationConfig.xml
weblogic/user_projects/domains/base_domain/bin/startManagedWebLogic.sh wcsites_server1
