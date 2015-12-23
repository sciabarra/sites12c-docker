#!/bin/bash

while ! nc shared.loc 1521 </dev/null 2>/dev/null
do sleep 1 ; echo waiting for database
done
echo wait 20 sec
sleep 5
echo wait 15 sec
sleep 5
echo wait 10 sec
sleep 5
echo wait 5 sec
sleep 5
bash config-database.sh
bash config-weblogic.sh
