*** Settings ***
Library    ../../Components/AzureAutomationLib.py
*** Tasks ***
Set Automation in Azure Devops
    Set Azure Value    347300    name=${SUITE_NAME}
    ${name_value}=    Check Values    347300    AutomatedTestName
    ${automation_value}=    Check Values    347300    AutomationStatus
    Should Be Equal As Strings    ${name_value}    ${SUITE_NAME}
    Should Be Equal As Strings    ${automation_value}    Automated
