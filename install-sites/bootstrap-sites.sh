#!/bin/bash
HOST=${1:?host}
PORT=${2:?port}
DATABASE=${3:?database}
PASSWORD=${4:?password}
if test "$DATABASE" == "HSQLDB"
then DATASOURCE="wcsitesHSQL"
else DATASOURCE="wcsitesDS"
fi
mkdir -p /app/shared
sed \
 -e "s/oracle\.wcsites\.shared=.*/oracle.wcsites.shared=\/app\/shared/" \
 -e "s/bootstrap\.status=.*/bootstrap.status=never_done/" \
 -e "s/database\.type=.*/database.type=$DATABASE/" \
 -e "s/database\.datasource=.*/database.datasource=$DATASOURCE/" \
 -e "s/wcsites\.hostname=.*/wcsites\.hostname=$HOST/" \
 -e "s/wcsites\.portnumber=.*/wcsites\.portnumber=$PORT/" \
 -e "s/cas\.portnumber=.*/cas\.portnumber=$PORT/" \
 -e "s/cas\.hostname=.*/cas\.hostname=$HOST/" \
 -e "s/cas\.hostnameActual=.*/cas\.hostnameActual=$HOST/" \
 -e "s/cas\.hostnameLocal=.*/cas\.hostnameLocal=localhost/" \
 -e "s/cas\.portnumberLocal=.*/cas\.portnumberLocal=$PORT/" \
 -e "s/password=.*/password=$PASSWORD/" \
 -e "s/admin.user=.*/admin.user=ContentServer/" \
 -e "s/satellite.user=.*/satellite.user=SatelliteServer/" \
 -e "s/app.user=.*/app.user=fwadmin/" \
 <weblogic/wcsites/webcentersites/sites-home/template/config/wcs_properties_bootstrap.ini \
 >weblogic/user_projects/domains/base_domain/wcsites/wcsites/config/wcs_properties_bootstrap.ini
