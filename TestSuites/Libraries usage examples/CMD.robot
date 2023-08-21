# *** Settings ***
# Library    WhiteLibrary
# Library    Process
# Library    Telnet
# Library    AutoItLibrary

# *** Variable ***
# ${CMD}         C:\\Windows\\System32\\cmd.exe
# ${cmdtitle}    C:\\Windows\\System32\\cmd.exe
# ${textarea}    name:Text Area

# *** Test Cases ***
# Open CMD
  # Launch Application        ${CMD}
  # Wait For Active Window    ${cmdtitle}    
  # Send    123
  # Send    {ENTER}