*** Settings ***
Library    SeleniumLibrary
Library    ../../Components/WebDriverSetup.py
Resource    ../../Components/TestBase.robot
Variables    ../../Parameters/Params.py
Test Teardown    Teardown
Suite Teardown    Close All Browsers

*** Variables ***
${test_url}    http://demo.guru99.com/test/facebook.html
${name_input_field}    name=email
${pass_input_field}    name=pass
${submit_button}    id=u_0_b

*** Test Cases ***
Basic syntax
    [Tags]    selenium
    Open browser to login page 
    Login as anonymous with password secret to Facebook
    Close browser
    
Behavior-driven
    [Tags]    selenium
    Given Open browser to login page 
    When Login as anonymous with password secret to Facebook
    Then Close browser
  
Multiple arguments together
    [Tags]    selenium
    What about "Los Angeles" "Lakers" ?
    What about "Chicago" "Bulls" ?
	
*** Keywords ***
Open browser to login page
    ${browser_path}=   WebDriverSetup.Get Browserdriver Path    ${BROWSER}
    Open browser    ${test_url}    ${BROWSER}    executable_path=${browser_path}
    Maximize browser window

Login as ${user} with password ${pass} to Facebook
    Page should contain element    ${name_input_field}
	Page should contain element    ${pass_input_field}
	
	Input text  ${name_input_field}    ${user} 
	Input text  ${pass_input_field}    ${pass}
	Click button    ${submit_button}
	
What about "${city}" "${team}" ?
    Log     Team ${team} is from ${city}