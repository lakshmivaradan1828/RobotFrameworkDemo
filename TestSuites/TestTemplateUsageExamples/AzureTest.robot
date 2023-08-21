*** Settings ***
Library          OperatingSystem
Library          ${CURDIR}/../../Components/AzureDataLib.py    323241    ${SUITE_NAME}
Library          DataDriver    file=${CURDIR}/../../${SUITE_NAME}.xlsx
Test Template    Log Arguments
*** Test Cases ***
tc1 ${user} ${password}
*** Keywords ***
Log Arguments
    [Arguments]    ${user}    ${password}
    Log    ${user}
    Log    ${password}
    Log    ${SUITE_NAME}
