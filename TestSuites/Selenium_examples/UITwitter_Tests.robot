*** Settings ***
Library    SeleniumLibrary
Library    String   
Variables    ../../Parameters/Params.py
Resource    ../../Pages/UITwitter.robot
Resource    ../../Components/TestBase.robot
Default Tags    selenium        


*** Test Cases ***
Login to X
    Open browser To Twitter 
    #Login to UITwitter   waseemullavolvo   Testvolvo@123
    Login to UITwitter    LakTestAutothon    mynameislak
    
    Create a Twitter post    Super happy to participate in #TESTAUTOTHON2023 organised by @stepin_forun in partnership with @verity_software. This event is running in parallel with #STEPINSUMMIT2023
    

    #Create a Twitter post    THe participation is amazing and about 35 teams are participating in this #TESTAUTOTHON2023. Volvo group @stepin_forum@verity_software

    #Search Twitter post
    LogOut to UITwitter 
      
