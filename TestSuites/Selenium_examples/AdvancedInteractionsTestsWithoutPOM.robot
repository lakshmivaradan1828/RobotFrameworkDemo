*** Settings ***
Library    SeleniumLibrary
Library    ../../Components/WebDriverSetup.py
Resource    ../../Components/TestBase.robot
Variables    ../../Parameters/Params.py
Test Teardown    Teardown
Suite Teardown    Close All Browsers

*** Variables ***
${slider_button}    id=generate
${sample_box}    id=sample-box
${draggable_source}    id=draggable
${draggable_target}    id=droppable
${dropped_message}   Get Text    xpath=//div[@id='droppable']/p
${login_input}    id=username
${password_input}    id=password
${login_button}    css=#login > button > i
${editor_link}    link=WYSIWYG Editor

*** Test Cases ***
Slider test
    [Tags]    selenium
    Open browser to page    https://letcode.in/slider
    Drag And Drop By Offset    ${slider_button}    10    0


Draggable test
    [Tags]    selenium    PASS
    Open browser to page    https://letcode.in/draggable
    Drag And Drop By Offset    ${sample_box}    20    20

DragAndDrop test
    [Tags]    selenium
    Open browser to page    https://letcode.in/dropable
    Drag And Drop    ${draggable_source}    ${draggable_target}
    Should Be String    ${dropped_message}    'Dropped!'

JSClickAndAlert test
    [Tags]    selenium
    Open browser to page    http://the-internet.herokuapp.com/login
    Input Text    ${login_input}     'tomsmith'
    Input Text    ${password_input}     'SuperSecretPassword'
    Execute Javascript     arguments[0].Click     ARGUMENTS    ${login_button}
    Execute Javascript    alert(arguments[0])    ARGUMENTS    'Welcome to the internet' 
    Execute Javascript    document.
	
    
JSScroll test
    [Tags]    selenium    PASS
    Open browser to page    http://the-internet.herokuapp.com/infinite_scroll
    Execute Javascript    window.scrollBy(0,250)

        
JSScrollIntoView test
    [Tags]    selenium    PASS
    Open browser to page    http://the-internet.herokuapp.com
    Scroll Element Into View    ${editor_link}