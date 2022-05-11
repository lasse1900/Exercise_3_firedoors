*** Settings ***
Library     lib/commands.py

*** Test Cases ***
Turn on Power supply 4 remotely
     ${out}=    RPS send commands     SetPower  4  1
     Should be equal    ${out}  ${True}

Verify power supply 4 is on
    ${out}=     RPS get power    GetPower
    should contain    ${out}  P64=1

Turn Power Supply 4 to a transient state
    ${out}=     RPS send commands    SetPower   4   0.5
    Should be equal    ${out}  ${True}

Verify power supply 4 is in transient state
    ${out}=     RPS get power    GetPower
    should contain    ${out}  P64=0.5  

Turn off Power supply 4 remotely
     ${out}=    RPS send commands     SetPower  4  0
     Should be equal    ${out}  ${True}

Verify power supply 4 is off
    ${out}=     RPS get power    GetPower
    should contain    ${out}  P64=0


*** Keywords ***
RPS send commands
    [Arguments]    ${command}    ${port}    ${state}
    ${output}=  Send cmds    ${command}     ${port}     ${state}
    [return]    ${output}

RPS get Power
    [Arguments]    ${command}
    ${output}=  Send cmds   ${command}
    [return]    ${output}