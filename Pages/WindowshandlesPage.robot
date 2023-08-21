*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String


*** Variables ***
${firstFr}    id=firstFr
${FirstNameInput}    name=fname
${LastNameInput}    name=lname
${innerFr}     //iframe[@class='has-background-white'] 
${EmailInput}      name=email
${EnteredText}    //p[@class='title has-text-info']

${input}    tomsmith
${SimpleAlertBtn}    id=accept
${ConfirmAlertBtn}      id=confirm 
${PromptAlertBtn}    id=prompt
${ResultText}    id=myName

${HomePageButton}    id=home
${MultiPageButton}    id=multi

${pagetitle}      Window handling

*** Keywords ***
Switchframeandfillform
    [Arguments]    ${firstname}    ${lastname}    ${email}
    Select Frame    ${firstFr}
    Input Text    ${FirstNameInput}    ${firstname}
    Input Text    ${LastNameInput}  ${lastname}
    Select Frame    ${innerFr} 
    Input Text    ${EmailInput}    ${email}
    Unselect Frame
    Select Frame    ${firstFr}    
    ${output}    Get Text    ${EnteredText}
    ${text}    Catenate     ${firstname}   ${lastname} 
    Should End With    ${output}    ${text}
    Unselect Frame
    
AcceptAlert
    Click Button    ${SimpleAlertBtn}
    ${msg}    Handle Alert   action=ACCEPT
    Log    ${msg}

ConfirmAlert
    [Arguments]    ${AlertOption}
    Click Button    ${ConfirmAlertBtn} 
    ${msg}    Run Keyword If    '${AlertOption}' == 'Ok'
    ...    Handle Alert    action=ACCEPT
    ...     ELSE IF    '${AlertOption}' == 'Cancel'
    ...   Handle Alert    action=DISMISS
    
PromptAlert
    [Arguments]    ${inputAlertText}
    Click Button    ${PromptAlertBtn}   
    Input Text Into Alert    ${inputAlertText}     action=ACCEPT
    ${output}    Get Text    ${ResultText}  
    @{prompttext}    Split String   ${output}    :
    ${prompt_text}   Replace String  ${prompttext}[1]   ${space}    ${empty}
    Should Be Equal As Strings    ${prompt_text}   ${inputAlertText}

ValidatenewWindow
    [Arguments]    ${new_window}
    Switch Window     ${new_window}
    Log Title
    Log Location
    Close window 

SwitchToNewWindow
    ${title}    Get Title    
    Should contain    ${title}    ${pagetitle}
    ${main_window}    Switch Window      
    Click Button    ${HomePageButton}

    @{windows}    Get Window Handles
    FOR    ${handles}    IN    @{windows}
        Log    ${handles}
        Run Keyword If  '${main_window}'!='${handles}'    ValidatenewWindow   ${handles}  
    END
    
    Switch Window    ${main_window}
    Should contain    ${title}    ${pagetitle}

MultipleWindowSwitch  
    ${title}    Get Title 
    Should Contain     ${title}    ${pagetitle}
    ${main_window}    Switch Window      
    Click Button    ${MultiPageButton}

    @{windows}    Get Window Handles
    FOR    ${handles}    IN    @{windows}
        Log    ${handles}
        Run Keyword If  '${main_window}'!='${handles}'    ValidatenewWindow   ${handles} 
    END
    
    Switch Window    ${main_window}
    Should contain    ${title}    ${pagetitle}