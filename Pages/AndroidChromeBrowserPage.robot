*** Settings ***
Library           AppiumLibrary

*** Variables ***
${appium_URL}    http://localhost:4723/wd/hub
${platform_name}    Android
${platform_version}    7.0
${device_name}    here_enter_your_device_Name
${device_udid}    here_enter_your_device_ID
${automation_name}    appium
${browser_name}    Chrome
${app_package}    com.google.android.apps.chrome
${app_activity}    com.google.android.apps.chrome.Main

*** Keywords ***
Open chrome browser on Android device
    Open Application  ${appium_URL}
             ...  platformName=${platform_name}
             ...  platformVersion=${platform_version}
             ...  deviceName=${device_name}
             ...  udid=${device_udid} 
             ...  automationName=${automation_name}  
             ...  browserName=${browser_name}
             ...  appPackage=${app_package} 
             ...  appActivity=${app_activity}
       
    
Open url ${url} and expect title ${text}
    Go to url    ${url}
    Page Should Contain Text    ${text}