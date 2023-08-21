*** Settings ***
Library    SeleniumLibrary
Library    Collections
Resource    ../../Pages/WindowshandlesPage.robot
Resource    ../../Components/TestBase.robot
Test Teardown    Teardown
Default Tags    UI

*** Test Cases ***
IframeSwitch
      Open browser to page    https://letcode.in/frame
      Switchframeandfillform    Tom    Smith    tom.smith@email.com

AcceptAlertTest
    [Tags]    PASS
    Open browser to page    https://letcode.in/alert
    AcceptAlert

ConfirmAlertTest
    [Tags]    PASS
    Open browser to page    https://letcode.in/alert
    ConfirmAlert    Ok

RejectAlertTest
    Open browser to page    https://letcode.in/alert
    ConfirmAlert    Cancel

PromptAlertTest
    Open browser to page    https://letcode.in/alert
    PromptAlert    ${input} 

WindowSwitchTest
    Open browser to page    https://letcode.in/windows
    SwitchToNewWindow

MultipleWindowSwitchTest
    Open browser to page    https://letcode.in/windows
    MultipleWindowSwitch
