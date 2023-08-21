*** Settings ***
Library    Mainframe3270
Library    ExcellentLibrary

*** Variables ***
${DATA_DIR}         "C:\Automacao_Testes\zOS\Data\Data.xlsx"
${Environment}      "LOGON CIBRAD1"
${Hostname}         "brvse3.cta.volvo.net"
${IMG_DIRECTORY}    "../IMG"
${Login_Page}       "WELCOME TO VOLVO BRAZIL DEVELOPMENT"
${NewPassword}      "<newpassword>"
${Password}         "<put your password here>"
${SignOn}           "Signon OK: User=<username> NAME=<full name>"
${Title}            "IS CONNECTED TO THE VOLVO NETWORK."
${User}             "<put your username here>"
${FB01}             0
${Index}            2
${Value}            0
${Walet}            R

*** Test Cases ***
Scenario: AB10 Update
  [tags]    mainframe
  Given the user is connected and input the transaction AB10
  When he informs the client and the new value
  Then the system must update the value

*** Keywords ***
### Test Setup
Login CICS
    Run Keyword    Open Emulador
    Run Keyword    the system must be in the home screen
    Run Keyword    set the environment
    Run Keyword    the system open the login page
    Run Keyword    input the user name
    Run Keyword    input the password
    Run Keyword    the system must Login in the CICS

### Teardown
Close Emulador
    Close Connection

### Given
Open Emulador
    Open Connection     ${Hostname}
    Change Wait Time    1.0
    Change Wait Time After Write    1.0
#    Set Screenshot Folder    ${IMG_DIRECTORY}

the system must be in the home screen
    Page Should Contain String    ${Title}
    
the user is connected and input the transaction AB10
  Write In Position   AB10    1   2
  ${AB10_PAGE} =      Read    2   31    20
  Should Be Equal     ${AB10_PAGE}    LIMITES PARA CLIENTE

### When
set the environment
    Wait Field Detected
    Write In Position         ${Environment}    5     1

input the user name
    Write Bare In Position    ${User}           12    21

input the password
    Write In Position         ${Password}       13    21
    ${Expirada}=  Read    19    19    14
    Run Keyword If    '${Expirada}'== 'SENHA EXPIRADA'    update password
    ${Invalida}=  Read    19    19    14
    Run Keyword If    '${Invalida}'== 'SENHA INVALIDA'    login with new password

input the transaction "${Transaction}"
    Write In Position    ${Transaction}    1    2
    
he informs the client and the new value
  Open Workbook     ${DATA_DIR}
  Switch Sheet      AB10
  ${Row} =    Get Row Count
  ${Row} =    Evaluate    ${Row}+1
  FOR   ${Index}  IN RANGE   2   ${Row}
    Set Global Variable    ${Index}    ${Index}
    Run Keyword    read data
    Run Keyword    update AB10
  END
  Close Workbook

### Then
the system open the login page
    Wait Field Detected
    Page Should Contain String    ${Login_Page}

the system must Login in the CICS
    Wait Field Detected
    Page Should Contain String    ${SignOn}

the system must update the value
    No Operation

### Auxiliary class
update password
    Write Bare In Position    ${NewPassword}    21    28
    Write In Position         ${NewPassword}    22    28

login with new password
    Write In Position         ${NewPassword}    17    28
    
read data
  ### Read Column values - Start ###
  ${FB01} =   Read From Cell    (1,${Index})
  Set Global Variable    ${FB01}    ${FB01}
  ${Value} =  Read From Cell    (2,${Index})
  Set Global Variable    ${Value}    ${Value}
  ${Walet} =  Read From Cell    (3,${Index})
  Set Global Variable    ${Walet}    ${Walet}
  ### Read Column values - Finish
  
update AB10
  Wait Field Detected
  Write Bare In Position    ALTE      24  10
  Write In Position   ${FB01}   24    57
  Wait Field Detected
  Write Bare In Position    ${Value}  6   19
  Write In Position   ${Walet}  21    21
  Send Enter
