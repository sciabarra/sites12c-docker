#!/bin/bash
while ! curl http://$(cat host.txt):7003/sites/HelloCS | grep Success
do sleep 1 ; done
curl http://$(cat host.txt):7003/sites/sitesconfig
touch http.log
while ! grep "Sites Configuration finished successfully" http.log
do curl -s http://$(cat host.txt):7003/sites/configresources/configprogressdynamic.jsp |\
   grep "steps" | tee http.log
   sleep 1
done
