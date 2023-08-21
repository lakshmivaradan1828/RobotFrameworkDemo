*** Settings ***
Documentation    Tests the AutoItLibrary by using various AutoIt keywords on the GUI of the Windows Calculator application.
Library    AutoItLibrary    ${OUTPUTDIR}    10
Library    Collections    
Library    String

*** Variables ***
${MENUMAP}
${GUIMAP}

*** Keywords ***
Clear Calculator
    [Documentation]    Click the Clear button in the Windows Calculator
    Win Activate    Calculator
    Click Button    Clear

Initalize variables
    ${GUIMAP} =    Create Dictionary    0=Button6	1=Button5    2=Button11    3=Button16    4=Button4    5=Button10    6=Button15    7=Button3    8=Button9    9=Button14    /=Button20    *=Button21    -=Button22    +=Button23    equals=Button28	Hex=Button1    Dec=Button2    Oct=Button3    Bin=Button4	Qword=Button5    Dword=Button6    Word=Button7    Byte=Button8    C=Button13    Clear=Button13
    Set Suite Variable   ${GUIMAP}
    ${MENUMAP} =    Create Dictionary    View Standard=VT    View Scientific=VS    View Decimal=VD    View Hex=VP    View Digit grouping=VI    Edit Copy=EC    Edit Paste=EP    Exit={F4}
    Set Suite Variable   ${MENUMAP}
    
Start Calculator 
    [Documentation]     Start the Windows Calculator application and set the default settings that the rest of the tests expect. 
    Initalize variables
    Run     calc.exe   
    Wait For Active Window     Calculator   
    Select Calculator Menu Item    View Scientific   
    Wait For Active Window     Calculator     Degrees  
    Comment     We want "Digit Grouping" off but there's no way to examine the check beside the menu item. So we need to try recognizing some displayed digits to see if its on or off and then change it if necessary.   
    Send     12345   
    ${Result}     ${ErrMsg} =     Run Keyword And Ignore Error     Win Wait 
    ...     Calculator     12345     3 
    Run Keyword If     "${Result}" == "FAIL"     Select Calculator Menu Item     View Digit grouping 
    Win Wait     Calculator     12345  
    Click Button     Clear  
    
Stop Calculator 
    [Documentation]     Shut down the Windows Calculator application. 
    Win Activate     Calculator   
    Select Calculator Menu Item     Exit 

Click Button 
    [Arguments]     ${ButtonText}   
    [Documentation]     Click a button by its text name, using the Calculator GUI Map. 
    ${ButtonName} =     Get From Dictionary     ${GUIMAP}     ${ButtonText} 
    Control Click     Calculator     ${EMPTY}     ${ButtonName} 
    
Click Buttons 
    [Arguments]     ${ButtonNames}   
    [Documentation]     Click a sequence of buttons by their text names, using the Calculator GUI Map.
    ...    Button text names should be separated by white space. 
    @{Buttons} =     Split String     ${ButtonNames}  
    :FOR     ${ButtonName}     IN     @{Buttons} 
    \    Click Button     ${ButtonName} 
 
Select Calculator Menu Item 
    [Arguments]     ${MenuItem}   
    [Documentation]     The Windows Calculator application doesn't really use a Windows GUI Menu to implement its menus. Therefore AutoIt can't see the menus as menu GUI objects. The only way to access the Calculator menus is via the ALT key sequences. In Win XP the Calculator menu ALT key letters are underlined, and thus available, all the time. Microsoft, in their wisdom, changed this in Win Vista so that you have to press the ALT key and "wait a bit" before the ALT key letters are underlined on the GUI. When they're not underlined, they don't work. Since AutoIt can send ALT key sequences VERY FAST, a sequence such as !VS (ALT+V+S) doesn't work on Win Vista, while it does work on Win XP. To get around this problem, and to make menu item selection more "tester friendly" we provide this keyword. It takes the name of a menu item as defined in the MENUMAP dictionary in the CalculatorGUIMap.py file. The MENUMAP dictionary items translate the application oriented menu name into the sequence of ALT keys to access that menu item. To make this work on Win XP and Win Vista, this keyword sends the ALT key first, waits a bit, then sends the sequence of keys from the MENUMAP. Complicated, but welcome to the wierd world of Windows GUI testing! 
    ${AltKeys} =     Get From Dictionary     ${MENUMAP}     ${MenuItem} 
    Send    '{ALTDOWN}'
    Sleep    1   
    Send     ${AltKeys}
    Send    '{ALTUP}'

Set Hex Mode 
    [Documentation]     Put the calculator in Hex arithmetic Dword mode. 
    Select Calculator Menu Item     View Hex   
    Click Buttons     Hex Dword   
    Sleep     1 sec 

Get Answer 
    [Documentation]     Get the answer via the clipboard, since the control is not accessible in the 6.1 version (it used to be "Edit1" in the 5.1 version). 
    Select Calculator Menu Item     Edit Copy   
    ${Answer} =     Clip Get   
    [Return]     ${Answer}   