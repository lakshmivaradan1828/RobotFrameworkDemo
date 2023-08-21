*** Settings ***
Documentation
...    Objective:  Test Skipped Testcase Reporting
Library          BuiltIn
Resource         ../../Components/TestBase.robot
Test Teardown     Teardown
Default Tags     smoke_test
*** Variables ***
${var}    EXPECTED
${INTERNET_LOGIN_PAGE}    https://the-internet.herokuapp.com/login
${userNameField}              id=username
${passwordField}              id = password
${loginButton}                css = #login > button > i
${logoutLink}                 xpath =//a[@href="/logout"]
${shouldBeSkippedProvider}    True

*** Keywords ***
Skip Test
    Set Test Variable    ${release}      R1
    Pass Execution    skipRest Of this Test    
Skip Test2
    Set Test Variable    ${release}      R1
    Pass Execution If    '${var}' == 'EXPECTED'    Skip the Rest!
    Log    123

login
  Input Text    ${userNameField}    tomsmith
  Input Text    ${passwordField}    SuperSecretPassword!
  Click Element    ${loginButton}
logout 
     Click Element   ${logoutLink}
    
*** Test Cases ***
Test_Skip
    # Check if Testcase is Relevant (should be skipped)
    # -------------------------------------------------
    Skip Test
    Should Be Equal    first    second 
    Log  ===========> *** RUNNING TEST_SKIP *** <===========
Test skip2 example
    Skip Test2
    Should Be Equal    first    second    

notSkippedTest
  [Documentation]   This test case will execute normally
  [Tags]  skip
   Open browser to page    ${INTERNET_LOGIN_PAGE}
   login
   logout 
  
skippedBeginTest
    [Documentation]  // This test case will be executed partially - SkipException will skip it at begin of test
    [Tags]  skip
    Pass Execution    Skipped this test at beginning
    Open browser to page   ${INTERNET_LOGIN_PAGE}
    login
    logout

skippedEndTest
    [Documentation]   This test case will be executed, but outcome will be ignored - SkipException will skip it at end of test
    [Tags]  skip
    Open browser to page    ${INTERNET_LOGIN_PAGE}
    login
    logout
    Pass Execution    Skipped this test at end

SkippedIfTest
    [Documentation]  This test case will be executed if condition is met - SkipException will skip it (or not) at begin of test
    [Tags]  skip
    Pass Execution If  '${shouldBeSkippedProvider}'=='True'    "test should be skipped dependending on the condition"
    Open browser to page    ${INTERNET_LOGIN_PAGE}
    login
    logout
       