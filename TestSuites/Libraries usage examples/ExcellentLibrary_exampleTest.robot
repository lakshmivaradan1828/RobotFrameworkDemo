*** Settings ***
Library    ExcellentLibrary
Library    Collections
 
*** Variables ***
${INDEX}              0
${Excel_File_Path}    C:\\Automacao_Testes\\SuiteSiteTestePractice\\
${Spreadsheet}        ExcelRobotTest.xlsx
${SheetName}          Graph Data
${NewSheetName}       NewSheet.xlsx
${Names}
*** Test Cases ***
Excel Test
    Get Values from Spreadsheet
    Add Data To Sheet
    Create a New Excel
    Add a New Sheet
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
Get Values from Spreadsheet
    Open Workbook       ${Excel_File_Path}    ${Spreadsheet}
    Switch Sheet        ${SheetName}
    ${ROW} =            Get Row Count
    FOR    ${INDEX}    IN RANGE     1    ${ROW}
        Set Global Variable     ${INDEX}     ${INDEX}
        Run Keyword     read data
    END
 
Add Data To Sheet
    Write To Cell     (1,1)     Test
    Save
    Close Workbook
 
Create a New Excel
    Create Workbook     ${Excel_File_Path}${NewSheetName}
    Save
    Close Workbook
 
Add a New Sheet
    Open Workbook     ${Excel_File_Path}${NewSheetName}
    Create Sheet      TCoE_Test
    Save
    Close Workbook
 
read data
    ### Read Column values - Start
    ${ColName1} =     Read From Cell     (1,${INDEX})
    Set Global Variable     ${ColName1}     ${ColName1}
    ${ColName2} =     Read From Cell     (2,${INDEX})
    Set Global Variable     ${ColName2}     ${ColName2}
    ### Read Column values - Finish