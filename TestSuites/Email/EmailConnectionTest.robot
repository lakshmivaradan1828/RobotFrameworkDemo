*** Settings ***
Library            SeleniumLibrary
Library            ../../Components/EmailLib.py
Resource           ../../Components/TestBase.robot
Variables          ../../Parameters/Params.py
Test Teardown      Teardown

*** Variables ***
${sent_from_email}       put email address of sender here - API mailbox
${sent_from_password}    put API mailbox password here
${to_email}              put email address of recipient here
${subject}               Ping
${message}               Hello, this is example of sending email


# In order to read/send emails via Robot Framework code, it is needed to have API Mailbox, because it is not allowed
# to use IMAP protocol in normal Outlook account. How to order API Mailbox:
# https://volvoitsm.service-now.com/sp?sys_kb_id=bb5128fa1b1ef81078b6a9bf6e4bcb51&id=kb_article_view&sysparm_rank=2&sysparm_tsqueryId=d0d732b81b6c5914dd956392f54bcb8e
*** Test Cases ***
Sending Email
    [Tags]    email
    EmailLib.Send Email    ${sent_from_email}    ${sent_from_password}    ${to_email}    ${subject}    ${message}

Reading Email
    [Tags]    email
    EmailLib.Read Emails    ${sent_from_email}    ${sent_from_password}