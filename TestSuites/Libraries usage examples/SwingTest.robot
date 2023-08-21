*** Settings ***
Library    RemoteSwingLibrary

*** Test Cases ***
My Test Case
    [tags]    swing
    Start Application    Java2D    C:\\tcoeGITRepo\\robotFramework\\ExternalLibs\\java2d.bat
    Application Started    Java2D    
    Select Window  Todo List
    Insert Into Text Field  Todo Item  buy milk
    Push Button  Add
    Select From List  todolist  0
    ${item}=  Get Selected Value From List  todolist
    Should Be Equal  ${item}  buy milk