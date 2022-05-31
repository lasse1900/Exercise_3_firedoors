*** Settings ***
Library       lib/commands.py

*** Variables ***
@{PINS} =    sf1    sf2    sf3    sf4
 
*** Keywords ***
RPS send commands
    [Arguments]    ${command}    ${port}    ${state}
    ${output}=    Send cmds    ${command}  ${port}  ${state}
    [return]    ${output}

RPS get Power
    [Arguments]    ${command}
    ${output}=    Send cmds    ${command}
    [return]    ${output}

*** Test Cases ***

Turn on Power supplies ON remotely
    FOR    ${pin}    IN    @{PINS}
        ${out}=    RPS send commands     SetPower    ${pin}  1
        Should be equal    ${out}  ${True}
    END

Turn on Power supplies ON remotely2
    ${len}=    Get Length    @{PINS_AMOUNT}
    ${counter}=    Set Variable    0
    ${limit}=    Set Variable    5
    Log    Executed until the given loop limit (3) is hit.
    WHILE    ${limit} < ${counter}
        Log    Executed until the given loop limit (3) is hit.
        ${out}=    RPS send commands     SetPower    ${PINS}  1
    END

Verify power pins are on
    FOR    ${pin}    IN    @{PINS}
        ${out}=     RPS get power    GetPower
        should contain    ${out}  ${pin}=1
    END    

Turn on Power supplies OFF remotely
    FOR    ${pin}    IN    @{PINS}
        ${out}=     RPS send commands    SetPower    ${pin}    0
        Should be equal    ${out}  ${True}   
    END    

Verify power supplies are off
    FOR    ${pin}    IN    @{PINS}
        ${out}=     RPS get power    GetPower
        should contain    ${out}  ${pin}=0
    END    

