*** Settings ***
Library    String
Library    SeleniumLibrary
Library    WebDriverSetup.py
Variables    ../Parameters/Params.py

*** Variables ***
${DEFAULT_OPTIONS}    add_argument('--window-size=${WINDOWS_SIZE}');add_argument('--start-maximazed')
@{_tmp}    browserName: ${BROWSER},    platform: LINUX
${CAPABILITIES}    ${EMPTY.join(${_tmp})}

*** Keywords ***
Open browser to page
    [Arguments]    ${URL}=${DEFAULT_URL}
    ${browser_path}=   WebDriverSetup.Get Browserdriver Path    ${BROWSER}  
    Options builder
    Run Keyword If    "${DOCKERGRID.lower()}" == "true" and "${FAST_PROXY}" == ""
    ...    Open browser    ${URL}    browser=${BROWSER}    remote_url=http://localhost:4444/wd/hub    desired_capabilities=${CAPABILITIES}    executable_path=${browser_path}    options=${DEFAULT_OPTIONS}
    ...  ELSE
    ...    Open browser    ${URL}    ${BROWSER}    executable_path=${browser_path}    options=${DEFAULT_OPTIONS}    
    Maximize browser window    
    Set Selenium Speed    ${DELAY}   

Teardown
    Set Screenshot Directory         ./TestOutput/Screenshots/${SUITE NAME}
    Capture Page Screenshot     ${TEST NAME}.png
    Close Browser

Options builder    
    Run Keyword If    "${HEADLESS.lower()}" == "true"
    ...    Add headless mode to browser
    Run Keyword If    "${INCOGNITO.lower()}" == "true"
    ...    Add incognito mode to browser
    Run Keyword If    "${DOCKERGRID.lower()}" == "true"
    ...    Ingore certificate errors
    Run Keyword If    "${FAST_PROXY}" != ""
    ...    Send whole traffic through proxy
    
Add headless mode to browser
    ${DEFAULT_OPTIONS}=    Catenate    SEPARATOR=;    ${DEFAULT_OPTIONS}    add_argument('--headless');add_argument('--disable-gpu')
    Set Test Variable    ${DEFAULT_OPTIONS}

Add incognito mode to browser
    ${DEFAULT_OPTIONS}=    Catenate    SEPARATOR=;    ${DEFAULT_OPTIONS}    add_argument("--incognito")
    Set Test Variable    ${DEFAULT_OPTIONS}

Send whole traffic through proxy
    Ingore certificate errors
    ${DEFAULT_OPTIONS}=    Catenate    SEPARATOR=;    ${DEFAULT_OPTIONS}    add_argument("--proxy-server=${FAST_PROXY}")
    Set Test Variable    ${DEFAULT_OPTIONS}

Ingore certificate errors
    ${DEFAULT_OPTIONS}=    Catenate    SEPARATOR=;    ${DEFAULT_OPTIONS}    add_argument("--ignore-certificate-errors")
    Set Test Variable    ${DEFAULT_OPTIONS}