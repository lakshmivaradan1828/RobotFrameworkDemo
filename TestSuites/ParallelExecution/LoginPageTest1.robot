*** Settings ***
Library    SeleniumLibrary    
Resource    ../../Pages/LoginPage.robot
Suite Setup       Open browser to login page  
Test Setup        Go to login page
Test Template     Invalid login
Default Tags    parallel

*** Variables ***
${valid_user}    tomsmith
${invalid_user}    jakis_user
${valid_password}    SuperSecretPassword!
${invalid_password}    qF9Z3mciwBbV6aIS
${empty}

*** Test Cases ***                          username        password
empty login and password                    ${empty}        ${empty}
vlaid user invalid pass                     ${valid_user}	${invalid_password}
invalid user valid pass                     ${invalid_user}	${valid_password} 
empty user valid pass                       ${empty}	    ${valid_password} 
valid user empty pass                       ${valid_user}	${empty}
empty user invalid pass                     ${empty}	    ${invalid_password}
invalid user invalid pass                   ${invalid_user}	${invalid_password}
invalid user empty pass                     ${invalid_user}	${empty}
empty user and valid user instead pass      ${empty}        ${valid_user}