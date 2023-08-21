*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections

*** Variables ***
${slider}       //input[@id="generate"]
${wordLimit}    //h1[@class='subtitle has-text-info']
${getCountriesButton}     //button[text()='Get Countries']
${countriesElement}       //p[@class='has-text-primary-light']
${droppedMessage}         //div[@id='droppable']/p
${SampleBox}              //*[@id="sample-box"]
${draggableSource}        //*[@id="draggable"]
${droppableTarget}        //*[@id="droppable"]
${loginInput}             id =username
${passwordInput}          id =password
${loginButton}            //i[text()=" Login"]
${editorLink}             //a[text()="WYSIWYG Editor"]

*** Keywords ***
Move slider
    [Arguments]  ${Count}
    Set Focus To Element    ${slider}
    Drag And Drop By Offset    ${slider}    ${Count}    0

validateSliderMove
        ${text}    Get Text    ${wordLimit}
        @{numbers}    Split String    ${text}    :
        ${slidercount}  Convert To Integer    @{numbers}[1]
        Click Element    ${getCountriesButton}  
        ${countries}   Get Text    ${countriesElement}
        @{countriesList}    Split String   ${countries}    -
        ${countriescount}  Get Length    ${countriesList}
        Run Keyword If    ${slidercount}==${countriescount}   log  "Validation successful"
        ...  ELSE  log  "Validation not successful" 

 dragByOffset
     [Arguments]    ${XOff}    ${YOff}
     Drag And Drop By Offset   ${SampleBox}   ${XOff}    ${YOff}
     log    "success"

Dragdrop 
     Drag And Drop    ${draggableSource}     ${droppableTarget}
     Element Should Contain    ${droppedMessage}     Dropped!

loginAndDisplayAlert
    Input Text   ${loginInput}    tomsmith
    Input Text   ${passwordInput}    SuperSecretPassword!
    Execute Javascript   document.evaluate('${loginButton}',document.body,null,9,null).singleNodeValue.click();
    #js.executeScript("alert('Welcome to the internet')");

capturePageData
    ${url} =  Execute Javascript  return window.location.href;
    log  current URL: ${url}
    ${domain} =  Execute Javascript  return document.domain;
    log  Domain name: ${domain}
    ${title}=   Execute Javascript  return document.title;
    log  Page title: ${title}

scrollDown
    Execute JavaScript    window.scrollTo(0, 500)

scrollToEditor
    Scroll Element Into View   ${editorLink}   
