*** Settings ***
Library    SeleniumLibrary
Resource    ../Components/TestBase.robot
Variables    ../Parameters/Params.py

*** Variables ***
${first_name_input}                firstName
${last_name_input}                 lastName
${country_dropdown}                dropdown_7
${date_birth}                      dateOfBirthInput
${date_birth_lable}                dateOfBirth-label
${phone_input}                     userNumber
${user_name_input}                 username2
${subjects}                        subjectsInput
${hobbies}                         //*[@id="hobbiesWrapper"]/div[2]/div[2]/label
${current_address}                 currentAddress
${state}                           react-select-3-input
${submit_button}                   //*[@id="submit"]
${email_input}                     userEmail
${gender}                          //*[@id="genterWrapper"]/div[2]/div[2]/label
${result_form}                     closeLargeModal

*** Keywords ***
Open Browser To Registration Page
    Open browser to page    ${REGISTRATION_URL}

Go to registration page
    Go to     ${REGISTRATION_URL} 
    Registration Page Should Be Open
    
Registration Page Should Be Open
    Title should be     ToolsQA

Name and surname
    [Arguments]    ${name}    ${surname}
    Clear element text    ${first_name_input}
    Input text     ${first_name_input}    ${name}
    Clear element text    ${last_name_input}
    Input text     ${last_name_input}    ${surname}
    
Hobby
    Click Element             ${hobbies}              
    
Gender
    Click Element             ${gender}            
    
Country
    [Arguments]    ${country}
    Select from list by value    ${country_dropdown}    ${country}    
    
Birth Date
    [Arguments]    ${date}    
    Input Text    ${date_birth}     ${date} 
    Click Element   ${date_birth_lable} 
    
Phone Number
    [Arguments]    ${phone_number}
    Clear element text    ${phone_input}
    Input text    ${phone_input}    ${phone_number}
    
Username
     [Arguments]    ${name}
     Clear element text    ${user_name_input}
     Input text    ${user_name_input}    ${name}
     
Email
     [Arguments]    ${email}
     Clear element text    ${email_input}
     Input text    ${email_input}    ${email}
     
About Yourself
     [Arguments]    ${info}
     Input text    ${subjects}        ${info}
    
Submit Registration
    [Arguments]    ${flag}=True
    # Scroling the page to bypass ADS
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Click Button    ${submit_button}
    
Close Registration Form
    Click Button    ${result_form}
     