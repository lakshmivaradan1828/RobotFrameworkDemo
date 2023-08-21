*** Settings ***
Library    String
Library    DateTime
Default Tags    conditions    PASS

*** Variables ***
${greetings}

*** Test Cases ***
IF condition
    ${date}=    Get Current Date    result_format=datetime    
    ${greetings}=     Run Keyword if    ${date.hour} < 18    Set variable    Good day
    log    ${greetings}
    
ELSE condition
    ${date}=    Get Current Date    result_format=datetime    
    ${greetings}=     Run Keyword if    ${date.hour} < 18    Set variable    Good day
    ...    ELSE    Set variable    Good evening
    log    ${greetings}
    
ELSE IF condition
    ${date}=    Get Current Date    result_format=datetime    
    ${greetings}=     Run Keyword if    ${date.hour} < 10    Set variable    Good morning
    ...    ELSE IF    ${date.hour} < 20    Set variable    Good day
    ...    ELSE    Set variable    Good evening
    log    ${greetings}