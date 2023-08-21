*** Settings ***
Variables    ../../Parameters/Params.py
Resource    ../../Pages/RegistrationPage.robot
Resource    ../../Components/TestBase.robot
Test Teardown     Teardown
Suite Teardown    Close All Browsers

*** Test Cases ***
Registration
    [Tags]    selenium
    Given Open browser to registration page
    When Name and surname    Ferdynand    Kiepski
    And Email       ferdek1@gmail.com
    And Gender    
    And Phone number    4812948324443
    And Birth date    02 May 1991 
    And About Yourself    ${ABOUT_USER}
    And Hobby    
    And Submit Registration
    Then Close Registration Form