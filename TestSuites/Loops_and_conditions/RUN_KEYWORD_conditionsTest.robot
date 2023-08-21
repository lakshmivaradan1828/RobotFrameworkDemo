*** Settings ***
Default Tags    conditions    PASS

*** Test Cases ***
Run-Keyword
    ${MY_KEYWORD}=    Set Variable    Log
    Run Keyword    ${MY_KEYWORD}    Test

Run-Keyword-If
    ${TYPE}=    Set Variable    V1
    Run Keyword If    '${TYPE}' == 'V1'    Log     Testing Variant 1
    Run Keyword If    '${TYPE}' == 'V2'    Log    Testing Variant 2
    Run Keyword If    '${TYPE}' == 'V3'    Log    Testing Variant 3

Run-Keyword-Ignore-Error
    @{CAPTAINS}    Create List    Picard    Kirk    Archer
    Run Keyword And Ignore Error    Should Be Empty    ${CAPTAINS}
    Log    Reached this point despite of error