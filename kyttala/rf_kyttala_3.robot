*** Settings ***
Library       lib/commands.py

*** Variables ***
#@{S_DOORS}=    sf1    sf2    sf3    sf4
@{DOORS}=    1    2    3    4
 
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


Turn opening all doors
    TRY
        ${cnt}=    Get Length    @{S_DOORS}
        ${iDoor}=    Set Variable    ${0}
        ${limit}=    Set Variable    5
        WHILE    True    limit=${cnt}
            ${out}=    RPS send commands     SetPower    ${S_DOORS{${iDoor}}}    0
            Should be equal    ${out}    ${True}

            ${iDoor}=    set Variable    ${iDoor+1}
        END
    EXCEPT    WHILE loop has aborted    type=start
        Log    The loop did not finish within    ${iDoor}
    END

Turn on Power supply cities remotely
    ${cnt}=    Get Length     ${DOORS}
    ${cnt}=    Evaluate    ${cnt} + 1
    #Log    Num value is ${cnt}    console=yes
    ${x}=    Set Variable    1
    #Log    x value is ${x}    console=yes
    WHILE    ${x} < ${cnt}
        ${doorNum}=    Catenate    SEPARATOR=    sd    ${x}
        #Log    door value is ${doorNum}    console=yes
        ${out}=    RPS send commands     SetPower  ${doorNum}  1
        Should be equal    ${out}  ${True}
        ${x}=    Evaluate    ${x} + 1
        #Log    door value is ${x}    console=yes
    END

