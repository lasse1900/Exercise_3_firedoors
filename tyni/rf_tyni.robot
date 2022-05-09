*** Settings ***
Library       lib/commands_tyni.py

*** Test Cases ***
Turn on Power supply 1 remotely
     ${out}=    RPS send commands     SetPower  1  1
     Should be equal    ${out}  ${True}

Verify power supply 1 is on
    ${out}=     RPS get power    GetPower
    should contain    ${out}  P61=1

Turn off Power supply 1 remotely
     ${out}=    RPS send commands     SetPower  1  0
     Should be equal    ${out}  ${True}

Verify power supply 1 is off
    ${out}=     RPS get power    GetPower
    should contain    ${out}  P61=0

Turn on Power supply 2 remotely
     ${out}=    RPS send commands     SetPower  2  1
     Should be equal    ${out}  ${True}

Verify power supply 2 is on
    ${out}=     RPS get power    GetPower
    should contain    ${out}  P62=1

Turn off Power supply 2 remotely
     ${out}=    RPS send commands     SetPower  2  0
     Should be equal    ${out}  ${True}

Verify power supply 2 is off
    ${out}=     RPS get power    GetPower
    should contain    ${out}  P62=0

*** Keywords ***
RPS send commands
    [Arguments]    ${command}    ${port}    ${state}
    ${output}=    Send cmds    ${command}  ${port}  ${state}
    [return]    ${output}

RPS get Power
    [Arguments]    ${command}
    ${output}=    Send cmds    ${command}
    [return]    ${output}

