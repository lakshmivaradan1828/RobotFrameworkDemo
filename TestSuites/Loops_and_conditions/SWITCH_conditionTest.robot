*** Settings ***
Library    DateTime

*** Variables ***
${text}

*** Test Cases ***
SWITCH condition
    [Tags]    conditions    PASS
    ${date}=    Get Current Date    result_format=datetime
    log    ${date.month}
    ${text}=     Set variable if
    ...    ${date.month} == 1    January
    ...    ${date.month} == 2    February
    ...    ${date.month} == 3    March
    ...    ${date.month} == 4    April
    ...    ${date.month} == 5    May
    ...    ${date.month} == 6    June
    ...    ${date.month} == 7    July
    ...    ${date.month} == 8    August
    ...    ${date.month} == 9    September
    ...    ${date.month} == 10    October
    ...    ${date.month} == 11    November
    ...    ${date.month} == 12    December
    log    ${text}
    
SWITCH DEFAULT condition
    [Tags]    smoke    PASS
    ${day}=    Get Current Date    result_format=%A    
    log    ${day}
     ${text}=     Set variable if
     ...    '${day}' == 'Saturday'    OR     '${day}' == 'Sunday'    It is weekend
     ...    '${day}' == 'Thursday'    OR     '${day}' == 'Friday'    Soon it is Weekend
     ...    Looking forward to the Weekend
     log    ${text}