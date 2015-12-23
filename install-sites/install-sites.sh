#!/bin/bash

while ! nc shared.loc 1521 </dev/null 2>/dev/null
do sleep 1 ; echo waiting for database
done
sleep 10 

bash config-sites.sh
