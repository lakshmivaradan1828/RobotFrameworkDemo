*** Settings ***
Documentation    Tests the AutoItLibrary by using various AutoIt keywords on the GUI of the Windows Calculator application.
Library    AutoItLibrary
Library    String
Suite Setup    Start Calculator    
Suite Teardown    Stop Calculator    
Test Setup    Clear Calculator 
Resource    ../../Modules/CalculatorModule.robot
Default Tags    autoit

*** Test Cases ***
Integer Addition
    [Documentation]    Get "The Answer" by addition. 
    [Tags]    smoke
    Click Buttons     4 1 + 1 equals   
    Win Wait     Calculator     42
    ${Ans} =     Get Answer   
    Should Be Equal As Numbers     ${Ans}     42 

Integer Subtraction 
    [Documentation]     Get "The Answer" by subtraction. 
    [Tags]    smoke    calculator
    Click Buttons     4 5 - 3 equals   
    Win Wait     Calculator     42  
    ${Ans} =     Get Answer   
    Should Be Equal As Numbers     ${Ans}     42 
    
Integer Multiplication 
    [Documentation]     Get "The Answer" by multiplication. 
    Click Buttons     6 * 7 equals   
    Win Wait     Calculator     42  
    ${Ans} =     Get Answer   
    Should Be Equal As Numbers     ${Ans}     42 

Integer Division 
    [Documentation]     Get "The Answer" by division. 
    Click Buttons     5 4 6 / 1 3 equals   
    Win Wait     Calculator     42  
    ${Ans} =     Get Answer   
    Should Be Equal As Numbers     ${Ans}     42 

Hex Addition 
    [Documentation]     Test Hex addition. 
    [Setup]     Set Hex Mode   
    Send     DE01F100   
    Click Button     +   
    Send     ABCDEF   
    Click Button     equals 
    Win Wait     Calculator     DEADBEEF  
    ${Ans} =     Get Answer   
    Should Be Equal As Strings     ${Ans}     DEADBEEF 

Hex Subtraction 
    [Documentation]     Test Hex subtraction. 
    [Setup]     Set Hex Mode   
    Clip Put     DF598CDE   
    Select Calculator Menu Item     Edit Paste   
    Win Wait     Calculator     DF598CDE  
    Click Button     -   
    Clip Put     ABCDEF   
    Select Calculator Menu Item     Edit Paste   
    Win Wait     Calculator     ABCDEF  
    Click Button     equals   
    Win Wait     Calculator     DEADBEEF  
    ${Ans} =     Get Answer   
    Should Be Equal As Strings     ${Ans}     DEADBEEF 

Test Screen Capture On FAIL 
    [Documentation]     Test that a screenshot is taken and included in the report file when an AutoItLibrary keyword fails.
    ...    This test will always fail. 
    [Tags]     ExpectedFAIL   
    [Setup]     Set Hex Mode   
    Send     DE01F100   
    Send     {+}   
    Send     ABCDEF   
    Send     equals   
    Win Wait     Calculator     DEADBEAT     3 

