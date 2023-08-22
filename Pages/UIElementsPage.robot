*** Settings ***
Library    SeleniumLibrary
Library    Collections

*** Variables ***
${timeout}    5
${header}    class:heading
${dropdown}    id:dropdown
${testDropdown}    id:cars   
${checkbox}    id:bmwcheck
${radiobutton}    id:bmwradio
${radiobutton_grpname}    cars
${radiobutton_value}    bmw
${radiobutton_value1}    audi

*** Keywords ***
Select Bylabel
    Wait Until Element Is Visible  ${dropdown}  ${timeout}
    Select From List By Label     ${dropdown}   Option 1

Select Byvalue
    Wait Until Element Is Visible  ${dropdown}  ${timeout}
    Select From List By Value    ${dropdown}    2

Select ByIndex
    Wait Until Element Is Visible  ${dropdown}  ${timeout}
    Select From List By Index    ${dropdown}    1

Validate dropdown list
    Wait Until Element Is Visible  ${testDropdown}  ${timeout}

    ${status}    Run Keyword And Return Status    Select All From List    ${testDropdown}    
    Run Keyword If   '${status}' == 'true'
    ...  Log    Multiple values from the list can be selected
    ...  ELSE
    ...  Log    Multiple values from the list can not be selected  
    Unselect All From List    ${testDropdown}    
   
    Select From List By Value     ${testDropdown}    volvo
    Unselect From List By Value     ${testDropdown}    volvo

    Select From List By Index    ${testDropdown}    1
    Unselect From List By Index    ${testDropdown}    1
    
    Select From List By Label    ${testDropdown}    Opel
    ${selectedOption}    Get Selected List Label    ${testDropdown}
    Should Be Equal    ${selectedOption}    Opel
    Unselect From List By Label    ${testDropdown}    Opel
    
    Unselect All From List    ${testDropdown}
    

Validate CheckboxUsage
    Page Should Contain Checkbox    ${checkbox}
    Select Checkbox    ${checkbox}
    Checkbox Should Be Selected    ${checkbox}
    Unselect Checkbox    ${checkbox}
    Checkbox Should Not Be Selected    ${checkbox}


Validate RadiobuttonUsage 
    Page Should Contain Radio Button    ${radiobutton}
    Radio Button Should Not Be Selected    ${radiobutton_grpname}
    ${Status}    Run Keyword And Return Status    Select Radio Button    ${radiobutton_grpname}    ${radiobutton_value}
    Should Be True    ${Status}
    Radio Button Should Be Set To    ${radiobutton_grpname}    ${radiobutton_value}
    