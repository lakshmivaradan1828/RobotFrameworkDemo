*** Settings ***
Library           AppiumLibrary

*** Variables ***
${REMOTE_URL}     http://127.0.0.1:4723/wd/hub
${PLATFORM_NAME}    Android
${PLATFORM_VERSION}    7.0
${DEVICE_NAME}    here_enter_your_device_Name
${appBinary}            ${CURDIR}/Android_demo_apps/ContactManager.apk
${deviceId}    here_enter_your_device_ID

*** Keywords ***
add new contact
    [Arguments]    ${contact_name}    ${contact_phone}    ${contact_email}
    Open Application  ${REMOTE_URL}  
                ...    platformName=Android  
                ...    platformVersion=${PLATFORM_VERSION}  
                ...    deviceName=${DEVICE_NAME}  
                ...    app=${appBinary}  
                ...    automationName=appium  
                ...    appPackage=com.example.android.contactmanager
    Click Element    accessibility_id=Add Contact
    Input Text    id=com.example.android.contactmanager:id/contactNameEditText    ${contact_name}
    Input Text    id=com.example.android.contactmanager:id/contactPhoneEditText    ${contact_phone}
    Input Text    id=com.example.android.contactmanager:id/contactEmailEditText    ${contact_email}
    Click Element    accessibility_id=Save
    
    