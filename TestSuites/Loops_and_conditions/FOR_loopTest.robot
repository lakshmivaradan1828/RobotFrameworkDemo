*** Settings ***
Library           String
Default Tags    loops    PASS

*** Test Cases ***
For-Loop-In-Range
    FOR    ${INDEX}    IN RANGE    1    10
        Log    ${INDEX}
        ${RANDOM_STRING}=    Generate Random String    ${INDEX}
        Log    ${RANDOM_STRING}
    END
For-Loop-Elements
    @{ITEMS}    Create List    Star Trek    Star Wars      Blade Runner    John Wick    King Kong
    FOR    ${ELEMENT}    IN    @{ITEMS}
        Log    ${ELEMENT}
        ${ELEMENT}    Replace String    ${ELEMENT}    ${SPACE}    ${EMPTY}
        Log    ${ELEMENT}
    END
Repeat-Action
    Repeat Keyword    5    Log    Lorem ipsum dolor sit amet