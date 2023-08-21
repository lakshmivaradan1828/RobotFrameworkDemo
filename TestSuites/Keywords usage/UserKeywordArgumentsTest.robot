*** Test Cases ***
Positional arguments
    One Argument    arg1
    Three Arguments    arg1    arg2    arg3

Default values with user keywords
    One Argument With Default Value
    One Argument With Default Value    arg1
    Two Arguments With Defaults
    Two Arguments With Defaults    arg1
    Two Arguments With Defaults    arg2=new value
    Two Arguments With Defaults    arg1    arg2
    One Required And One With Default    arg1
    One Required And One With Default    arg1    arg2
    Default Based On Earlier Argument    arg1
    Default Based On Earlier Argument    arg1    arg2
    Default Based On Earlier Argument    arg1    arg3=new value

Varargs with user keywords
    Any Number Of Arguments
    Any Number Of Arguments    arg
    Any Number Of Arguments    arg1    arg2    arg3   arg4
    One Or More Arguments    required
    One Or More Arguments    arg1    arg2    arg3   arg4
    Required, Default, Varargs    required
    Required, Default, Varargs    required    optional
    Required, Default, Varargs    arg1    arg2    arg3    arg4    arg5

*** Variables ***
${VARIABLE}    variable argument

*** Keywords ***
One Argument
    [Arguments]    ${arg_name}
    Log    Got argument: ${arg_name}

Three Arguments
    [Arguments]    ${arg1}    ${arg2}    ${arg3}
    Log    1st argument: ${arg1}
    Log    2nd argument: ${arg2}
    Log    3rd argument: ${arg3}
    
One Argument With Default Value
    [Arguments]    ${arg}=default value
    [Documentation]    This keyword takes 0-1 arguments
    Log    Got argument: ${arg}

Two Arguments With Defaults
    [Arguments]    ${arg1}=default 1    ${arg2}=${VARIABLE}
    [Documentation]    This keyword takes 0-2 arguments
    Log    1st argument: ${arg1}
    Log    2nd argument: ${arg2}

One Required And One With Default
    [Arguments]    ${required}    ${optional}=default
    [Documentation]    This keyword takes 1-2 arguments
    Log    Required: ${required}
    Log    Optional: ${optional}

 Default Based On Earlier Argument
    [Arguments]    ${a}    ${b}=${a}    ${c}=${a} and ${b}
    Should Be Equal    ${a}    ${b}
    Should Be Equal    ${c}    ${a} and ${b}
    
 Any Number Of Arguments
    [Arguments]    @{varargs}
    Log Many    @{varargs}

One Or More Arguments
    [Arguments]    ${required}    @{rest}
    Log Many    ${required}    @{rest}

Required, Default, Varargs
    [Arguments]    ${req}    ${opt}=42    @{others}
    Log    Required: ${req}
    Log    Optional: ${opt}
    Log    Others:
    : FOR    ${item}    IN    @{others}
    \    Log    ${item}