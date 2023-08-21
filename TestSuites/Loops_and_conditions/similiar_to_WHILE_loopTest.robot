*** Settings ***
Default Tags    loops    PASS

*** Settings ***
Documentation    Robot Framework does not have a while loop. 
...    You must use FOR-loop and "exit for loop if" keyword to exit. 
...    It will run a finite times, but if you select large enough number in range, it is close enough for practical purposes.

*** Test Cases ***
For-Loop-Exiting
    [Tags]    loops
    @{ITEMS}    Create List    incentivize virtual architectures    reintermediate efficient channels    enhance dynamic synergies    Break On Me    evolve end-to-end action-items
    FOR    ${ELEMENT}    IN    @{ITEMS}
        Log    ${ELEMENT}
        Run Keyword If    '${ELEMENT}' == 'Break On Me'    Exit For Loop
        Log    Do more actions here ...
     END
     
For-Loop-in-Range-Exiting
    FOR    ${i}    IN RANGE    999999
        Exit For Loop If    ${i} == 9
        Log    ${i}
    END
    Log    Exited