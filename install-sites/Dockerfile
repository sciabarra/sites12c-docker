FROM owcs/base-sites:latest
COPY host.txt *.sh *.py wcs_properties_bootstrap.ini.tmpl /app/
RUN sed -e "s/@HOST@/$(cat host.txt)/" <wcs_properties_bootstrap.ini.tmpl >wcs_properties_bootstrap.ini
CMD weblogic/user_projects/domains/base_domain/bin/startManagedWebLogic.sh wcsites_server1
