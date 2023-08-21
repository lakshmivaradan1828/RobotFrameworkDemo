*** Settings ***
Library           AppiumLibrary
Resource          ../../Modules/AndroidContactManagerModule.robot
Resource          ../../Modules/AndroidOrangeDemoAppModule.robot
Suite Teardown    Close Application
Default Tags    appium
*** Test Cases ***
add_contact
    add new contact    Appium User    5555555555    someone@appium.io
    Page Should Contain Text    Appium User
    
orange
    TestStart