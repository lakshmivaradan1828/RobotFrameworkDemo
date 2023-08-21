*** Settings ***
Library    REST     http://dummy.restapiexample.com/api/v1/      ssl_verify=false
Default Tags    rest

*** Variables ***
${JSON_VARIABLE}    {name:'test',salary:'123',age:'23'}
${ID}    1

*** Test Cases ***
Create new Employee - JSON as Variable
    [Tags]    rest
    Post    create       ${JSON_VARIABLE}
    Output    response body
    Integer    response status    200
    Integer    response body data id
    String    response body message    Successfully! Record has been added.    
    
Create new Employee - Using JSON File
    [Tags]    rest
    Post    create       ${CURDIR}/employee.json
    Output    response body
    Integer    response status    200
    Integer    response body data id
    String    response body message    Successfully! Record has been added.    
    
Get employees
    [Tags]    rest
    Get    employees
    Output    response body
    Integer    response status    200
    String    response body status    success
    Integer    $.data[*].id
    String    $.data[*].employee_name
    Integer    $.data[*].employee_salary
    Integer    $.data[*].employee_age
    String    response body message    Successfully! All records has been fetched.    
    
Get specific employee - Variable Parameter
    [Tags]    rest
    Get    employee/${ID}
    Output    response body
    Integer    response status    200
    String    response body status    success
    Integer    $.data.id    ${ID}
    String    $.data.employee_name    Tiger Nixon
    Integer    $.data.employee_salary    320800
    Integer    $.data.employee_age    61
    String    response body message    Successfully! Record has been fetched.   
            