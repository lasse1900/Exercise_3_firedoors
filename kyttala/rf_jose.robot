*** Settings ***
Library       lib/commands.py
Library       Collections

*** Variables ***
@{DOORS}=    1    2    3    4


*** Test Cases ***
Turn on Power supply cities remotely
    ${cnt}=    Get Length     ${DOORS}
    ${cnt}=    Evaluate    ${cnt} + 1
    Log    Num value is ${cnt}    console=yes
    ${x}=    Set Variable    1
    Log    x value is ${x}    console=yes
    WHILE    ${x} < ${cnt}
        ${doorNum}=    Catenate    SEPARATOR=    sf    ${x}
        Log    door value is ${doorNum}    console=yes
        ${out}=    RPS send commands     SetPower  ${doorNum}  1
        Should be equal    ${out}  ${True}
        ${x}=    Evaluate    ${x} + 1
        Log    door value is ${x}    console=yes
    END

Verify power supply cities is on
    TRY
        ${cnt}=    Get Length     ${DOORS}
        ${cnt}=    Evaluate    ${cnt} + 1
        ${x}=    Set Variable    1
        #Log    x value is ${x}    console=yes
        WHILE    ${x} < ${cnt}
            ${doorNum}=    Catenate    SEPARATOR=    sf    ${x}
            #Log    door value is ${doorNum}    console=yes
            ${out}=     RPS get power    GetPower
            should contain    ${out}  ${doorNum}=1
            ${x}=    Evaluate    ${x} + 1
            #Log    door value is ${x}    console=yes
        END
    EXCEPT    Error message
        Log    EXCEPT with no arguments should catch all execption. 
    END

Turn off Power supply cities remotely
    FOR    ${door}    IN    @{DOORS}
        ${doorNum}=    Catenate    SEPARATOR=    sf    ${door}
        ${out}=    RPS send commands     SetPower  ${doorNum}  0
        Should be equal    ${out}  ${True}
    END

Verify power supply cities is off
    TRY
        ${cnt}=    Get Length     ${DOORS}
        ${cnt}=    Evaluate    ${cnt} + 1
        ${x}=    Set Variable    1
        #Log    x value is ${x}    console=yes
        WHILE    ${x} < ${cnt}
            ${doorNum}=    Catenate    SEPARATOR=    sf    ${x}
            #Log    door value is ${doorNum}    console=yes
            ${out}=     RPS get power    GetPower
            should contain    ${out}  ${doorNum}=0
            ${x}=    Evaluate    ${x} + 1
            #Log    door value is ${x}    console=yes
        END
    EXCEPT    Error message
        Log    EXCEPT with no arguments should catch all execption. 
    END



*** Keywords ***
RPS send commands
    [Arguments]    ${command}    ${port}    ${state}
    ${output}=    Send cmds    ${command}  ${port}  ${state}
    [return]    ${output}

RPS get Power
    [Arguments]    ${command}
    ${output}=    Send cmds    ${command}
    [return]    ${output}

# RPS num doors 
#     [Arguments]    ${input}
#     ${num} =    Get length    ${input}
#     [return]    ${num}
