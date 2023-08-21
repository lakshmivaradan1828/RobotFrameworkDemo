*** Settings ***
Library    String
Library    DatabaseLibrary 
Library    ExcellentLibrary
# Resource   ../Libraries usage examples/
*** Variables ***
@{ITEMS}    Create List    Star Trek    Star Wars      Blade Runner    John Wick    King Kong
@{queryResults}    Query    Select * from the_database where ...
${Excel_File_Path}   C:\\Python27\\ExcelRobotTest\\
${Names}
${Spreadsheet}        ExcelRobotTest.xlsx
*** Test Cases ***
string
    ${str} =	Replace String	S.TestSuites.Test Template usage examples.InvalidLoginTest	S.TestSuites.	${EMPTY}	count=1
    Should Be Equal	${str}	Test Template usage examples.InvalidLoginTest
Template and FOR loop elements from the list
    [tags]    data-driven
    [Template]    Just log argument
    FOR    ${ELEMENT}    IN    @{ITEMS}
        ${ELEMENT}
    END
Template and FOR loop in range
    [tags]     data-driven
    [Template]    Just log index
    FOR    ${index}    IN RANGE    42
        ${index}
    END
Template and FOR loop elements from database
     [tags]     data-driven
    [Template]    Just log argument
    FOR    ${row}    IN    @{queryResults}
        ${row}
    END
Template and FOR loop elements from excel   
    [Tags]    Excel
    [Setup]    Get Values from Spreadsheet
    [Template]    Just log argument
    FOR    ${name}    IN    @{Names}
        ${name}
    END
*** Keywords ***

Just log argument
    [Arguments]    ${user}
    log    ${user}
    
Just log index
    [Arguments]    ${i}
    log    ${i}