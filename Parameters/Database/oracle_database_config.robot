*** Variables ***
${ODB_HOST}              segotl2251.srv.volvo.com
${ODB_PORT}              1523
${ODB_SERVICE_NAME}      gbaldt02.srv.volvo.com
${ODB_user}              'baldo_qa'
${ODB_pass}              'baldo_qa'
${ODB_CONNECT_STRING}    '(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=${ODB_HOST})(PORT=${ODB_PORT})))(CONNECT_DATA=(SERVICE_NAME=${ODB_SERVICE_NAME})))'