FROM owcs/2-weblogic:latest
COPY host.txt tailuntil.pl *.sh wcs_properties_bootstrap.ini.tmpl /app/
RUN sed -e "s/@HOST@/$(cat host.txt)/" <wcs_properties_bootstrap.ini.tmpl >wcs_properties_bootstrap.ini
CMD run-sites.sh
