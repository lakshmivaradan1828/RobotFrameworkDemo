*** Settings ***
Library    SeleniumLibrary
Library    ../Components/WebDriverSetup.py
Variables    ../Parameters/Params.py
Resource    ../Components/TestBase.robot
*** Variables ***
${username_input}    username
${password_input}    password
${login_button}    //*[@id="login"]/button
${login_error}    flash

*** Keywords ***
Invalid login
    [Arguments]    ${username}    ${password}
    Clear element text   ${username_input}
    Input text    ${username_input}   ${username} 
    Clear element text   ${password_input}
    Input text    ${password_input}   ${password} 
    Click button    ${login_button}
    Login Error Should Apear
    
Open browser to login page
    ${browser_path}=   WebDriverSetup.Get Browserdriver Path    ${BROWSER}
    Open browser    ${LOGIN_PAGE}    ${BROWSER}    executable_path=${browser_path}
    Maximize browser window    
    Set Selenium Speed    ${DELAY}
    
Go to login page
    Go to     ${LOGIN_PAGE}
    
Login Error Should Apear
    Wait Until Element Is Visible    ${login_error}    
