*** Settings ***
Resource    ../../Pages/AdvancedInterationsPage.robot
Resource    ../../Components/TestBase.robot
Test Teardown     Teardown
Suite Teardown    Close All Browsers
Library    SeleniumLibrary
Default Tags    selenium    PASS

*** Test Cases ***
sliderTest
    Open browser to page    https://letcode.in/slider
    Move slider    5
    validateSliderMove

draggableTest
        Open browser to page    https://letcode.in/draggable
        dragByOffset  20   20

dragNDropTest
        Open browser to page    https://letcode.in/dropable
        Dragdrop 

jSClickAndAlertTest
        Open browser to page    http://the-internet.herokuapp.com/login
        loginAndDisplayAlert

jsCapturePageDataTest
        Open browser to page     http://the-internet.herokuapp.com/login
        capturePageData

jsScrollTest
        Open browser to page    http://the-internet.herokuapp.com/infinite_scroll   
        scrollDown 

jsScrollIntoViewTest
        Open browser to page     http://the-internet.herokuapp.com    
        scrollToEditor
    