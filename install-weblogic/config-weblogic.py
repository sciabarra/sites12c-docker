readTemplate("%s/weblogic/wlserver/common/templates/wls/wls.jar" % os.environ['PWD'])
addTemplate("%s/weblogic/wlserver/common/templates/wls/wls_coherence_template.jar" % os.environ['PWD'])
addTemplate("%s/weblogic/oracle_common/common/templates/wls/oracle.jrf_template.jar" % os.environ['PWD'])
addTemplate("%s/weblogic/em/common/templates/wls/oracle.em_wls_template.jar" % os.environ['PWD'])
addTemplate("%s/weblogic/wcsites/common/templates/wls/oracle.wcsites.template.jar" % os.environ['PWD'])

# set pw
cd('Servers/AdminServer')
set('ListenPort', 7001)
cd('/')
cd('Security/base_domain/User/weblogic')
cmo.setPassword(sys.argv[2]) 

cd('/')
jdbcsystemresources = cmo.getJDBCSystemResources();
for res in jdbcsystemresources:
    print res
    cd ('/JDBCSystemResource/' + res.getName() + '/JdbcResource/' + res.getName() + '/JDBCConnectionPoolParams/NO_NAME_0');
    cd ('/JDBCSystemResource/' + res.getName() + '/JdbcResource/' + res.getName() + '/JDBCDriverParams/NO_NAME_0');
    cmo.setUrl(sys.argv[1]);
    cmo.setPasswordEncrypted(sys.argv[2])

cd("/JDBCSystemResource/wcsitesDS/JdbcResource/wcsitesDS/JdbcDriverParams/NO_NAME_0/Properties/NO_NAME_0/Property/user")
cmo.setValue(sys.argv[3]+"_WCSITES") 

# set an additional hsqldb datasource
cd('/')
create('wcsitesHSQL', 'JDBCSystemResource')
cd('JDBCSystemResource/wcsitesHSQL/JdbcResource/wcsitesHSQL')
create('myJdbcDriverParams','JDBCDriverParams')
cd('JDBCDriverParams/NO_NAME_0')
user = "sa"
passw = ""
table = "INFORMATION_SCHEMA.SYSTEM_USERS"

set('DriverName','org.hsqldb.jdbcDriver')
set('URL', 'jdbc:hsqldb:/app/shared/data/sitesDB')

set('PasswordEncrypted', passw)
set('UseXADataSourceInterface', 'false')
create('myProps','Properties')
cd('Properties/NO_NAME_0')
create('user', 'Property')
cd('Property/user')
cmo.setValue(user)

cd('/JDBCSystemResource/wcsitesHSQL/JdbcResource/wcsitesHSQL')
create('myJdbcDataSourceParams','JDBCDataSourceParams')
cd('JDBCDataSourceParams/NO_NAME_0')
set('JNDIName', java.lang.String("wcsitesHSQL"))

cd('/JDBCSystemResource/wcsitesHSQL/JdbcResource/wcsitesHSQL')
create('myJdbcConnectionPoolParams','JDBCConnectionPoolParams')
cd('JDBCConnectionPoolParams/NO_NAME_0')
set('TestTableName',table)
assign('JDBCSystemResource','wcsitesHSQL','Target','wcsites_server1')
 
# setOption('NoDependencyCheck', 'true')
writeDomain('%s/weblogic/user_projects/domains/base_domain' % os.environ['PWD'])
closeTemplate()

exit()
