#!/bin/bash
curl http://sites:7003/sites/sitesconfig
touch http.log
while ! grep "Sites Configuration finished successfully" http.log
do curl -s http://sites:7003/sites/configresources/configprogressdynamic.jsp |\
   grep "steps" | tee http.log
   sleep 1
done
