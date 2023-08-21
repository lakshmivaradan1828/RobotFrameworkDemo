*** Settings ***
Library    SoapLibrary
Library    OperatingSystem    

*** Variables ***
${Url}    http://www.dneonline.com/calculator.asmx?wsdl
${DIR}    C:\\tcoeRobotFramework

*** Test Cases ***
SoapUI Get Request
    [tags]    soap
    Create SOAP Client    ${Url}  
    ${response}           Call SOAP Method With XML    ${DIR}\\samplerequest.xml
    ${text}               Get Data From XML By Tag     ${response}    SubtractResult    
    log    ${text}
    Log To Console        ${text}   
    Save XML To File      ${response}    ${DIR}    response_test    