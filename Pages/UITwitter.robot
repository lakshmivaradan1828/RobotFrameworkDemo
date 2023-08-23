*** Settings ***
Library    SeleniumLibrary
Library    Collections
Variables   ../Parameters/Params.py

*** Variables ***
${textbox_username}    //input[@autocomplete='username']
${button_next}    //span[text()='Next']
${textbox_password}   //input[@autocomplete='current-password']
${button_login}    //*[@data-testid='LoginForm_Login_Button']
${label_AccountSwitcher}     //*[@data-testid='SideNav_AccountSwitcher_Button']
${label_logout}    //span[text()='Log out @waseemullavolvo']
${button_logout}    //*[@data-testid='confirmationSheetConfirm']
${button_post}      //a[@data-testid='SideNav_NewTweet_Button']

#post elements
${textbox_messageboxMain}    //*[@class='DraftEditor-root']
${textbox_messagebox}    //div[@class='public-DraftStyleDefault-block public-DraftStyleDefault-ltr']
${button_tweetbutton}       //div[@data-testid="tweetButtonInline"]

${searchResult}    //div[@data-testid="UserCell"]
*** Keywords ***
Open browser To Twitter    
    #Open browser to page  ${DEFAULT_URL}  
    Open browser to page     https://twitter.com/i/flow/login  
    Set Browser Implicit Wait    30
    Wait Until Element Is Visible    ${textbox_username}    20s  

Login to UITwitter
   [Arguments]    ${TWUser}    ${TWPassword} 
   Click Element    ${textbox_username} 
   Input text    ${textbox_username}    ${TWUser}
   Click Element    ${button_next} 
   Click Element    ${textbox_password} 
   Input text     ${textbox_password}    ${TWPassword}
   Click Element    ${button_login}
   Wait Until Element Is Visible    ${button_post}    20s  

LogOut to UITwitter   
    Wait Until Element Is Visible    ${label_AccountSwitcher}    20s  
    Click Element    ${label_AccountSwitcher} 
    Click Element    ${label_logout}
    Wait Until Element Is Visible    ${button_logout}    5s  
    Click Element    ${button_logout}

Create a Twitter post   
    [Arguments]    ${postText}  
   sleep  2s
   click Element  ${textbox_messageboxMain}  
   Input text    ${textbox_messagebox}       ${postText}
   click Element    ${button_tweetbutton}


Search Twitter post
    Input Text    //input[@data-testid="SearchBox_Search_Input"]    LakTestAutothon
    Press Keys    NONE    ENTER
    

    
    