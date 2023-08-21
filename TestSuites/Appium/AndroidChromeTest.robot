*** Settings ***
Library           AppiumLibrary
Resource    ../../Pages/AndroidChromeBrowserPage.robot  
Suite setup     Open chrome browser on Android device
Suite Teardown  Close Application
Default Tags    appium

*** Test Cases ***
Sportowe Fakty
    Open url http://www.sportowefakty.pl and expect title SportoweFakty
YouTube
    Open url https://www.youtube.com/ and expect title youtube  
Codecademy
    Open url https://www.codecademy.com/ and expect title Learn to code
Learn C#
    Open url https://www.learncs.org/ and expect title Learn C#