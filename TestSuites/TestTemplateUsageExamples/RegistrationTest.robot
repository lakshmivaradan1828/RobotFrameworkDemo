*** Settings ***
Library    SeleniumLibrary
Library    String    
Suite Setup       Open browser to registration page  
Suite Teardown    Close All Browsers
Test Setup        Go to registration page
Test Teardown    Teardown
Test Template     Registration
Variables    ../../Parameters/Params.py
Resource    ../../Pages/RegistrationPage.robot
Resource    ../../Components/TestBase.robot
Default Tags    selenium        

*** Test Cases ***              USERNAME      EMAIL                   VALID
Valid registration              Ferdek2    ferdek2@gmail.com
Registration with same email    Ferdek2    ferdek2@gmail.com    False
Registration another user       Ferdek3    ferdek3@gmail.com
    
*** Keywords ***
Registration
    [Arguments]    ${username}    ${email}    ${flag}=True
    Name and surname    Ferdynand    Kiepski
    Hobby    
    Country    Poland
    Birth date    02/05/1991
    Phone number    4812948324443
    Username    ${username} 
    Email       ${email}
    About Yourself    ${ABOUT_USER}
    ${pass}=    Generate Random String    12    [LETTERS][NUMBERS]
    Submit Registration    ${flag}
