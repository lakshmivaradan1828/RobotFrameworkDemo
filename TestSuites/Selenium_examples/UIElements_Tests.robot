*** Settings ***
Library    SeleniumLibrary
Library    Collections
Resource    ../../Pages/UIElementsPage.robot
Resource    ../../Components/TestBase.robot
Resource    ../../Pages/LoginPage.robot
Test Teardown    Teardown
Default Tags    UI    PASS

*** Test Cases ***
getTextTest
    Open browser to page     https://the-internet.herokuapp.com
    ${innerText}  Get Text   ${header}
    Should Be Equal    ${innerText}      Welcome to the-internet
    
selectByLabelTest
    Open browser to page    https://the-internet.herokuapp.com/dropdown   
    Select Bylabel

selectByValueTest
    Open browser to page    https://the-internet.herokuapp.com/dropdown   
    Select Byvalue

selectByIndexTest
    Open browser to page    https://the-internet.herokuapp.com/dropdown   
    Select ByIndex

multiSelectText
    Open browser to page    https://demoqa.com/select-menu   
    Validate dropdown list

CheckBoxUsage
    Open browser to page    https://courses.letskodeit.com/practice   
    Validate CheckboxUsage

radioButtonUsage
    Open browser to page    https://courses.letskodeit.com/practice  
    Validate RadiobuttonUsage