FROM owcs/2-weblogic:latest
COPY db.txt host.txt password.txt tailuntil.pl *.sh /app/
CMD /app/run-sites.sh ; tail -f /app/logs/sites.log
