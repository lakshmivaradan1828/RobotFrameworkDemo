*** Settings ***
Library         AppiumLibrary  run_on_failure=Log Source


*** Variables ***
${REMOTE_URL}  http://localhost:4723/wd/hub 

*** Keywords ***
TestStart
    [Documentation]  just demo
    Open Application  ${REMOTE_URL}  
                ...    platformName=Android
                ...    platformVersion=6.0.1  
                ...    deviceName=here_enter_your_device_Name 
                ...    app=${CURDIR}/Android_demo_apps/OrangeDemoApp.apk  
                ...    automationName=appium  
                ...    appPackage=com.netease.qa.orangedemo  
                ...    appActivity=MainActivity
    Capture Page Screenshot