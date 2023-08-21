*** Settings ***
Library    DatabaseLibrary 
Resource    ../../Parameters/Database/postgres_database_config.robot
Resource    ../../Parameters/Database/oracle_database_config.robot
Suite Teardown    Disconnect From Database

*** Test Cases ***


Connection to Postgres Database
    [Tags]    database
    Connect To Database    psycopg2    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
    ${queryResults}    Query    SELECT * FROM adm_user WHERE id = 'A049473'
    Log    ${queryResults}
    

Connect to Oracle Database
    [Tags]    database
    Connect To Database Using Custom Params    cx_Oracle    user=${ODB_user},password=${ODB_pass},dsn=${ODB_CONNECT_STRING}
    ${queryResults}    Query    SELECT * FROM adm_user WHERE id = 'A049473'
    Log    ${queryResults}