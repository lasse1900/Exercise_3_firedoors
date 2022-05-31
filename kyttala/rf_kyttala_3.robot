*** Settings ***
Library       lib/commands.py

*** Variables ***
@{S_DOORS}=    sf1    sf2    sf3    sf4    #It is a good practice to have a list of INTs instead

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
Test all doors open
    TRY
        ${cnt}=         Get Length      ${S_DOORS}
        ${iDoor}=       set variable    ${0} 
        WHILE   True    limit=${cnt}
            ${out}=     RPS send commands    SetPower        ${S_DOORS[${iDoor}]}    0  
            Should be equal                 ${out}          ${True}
            ${iDoor}=    set variable    ${iDoor+1}
        END
    EXCEPT    WHILE loop was aborted    type=start
        Log    The loop did not finish within ${iDoor}.
    END

Test all doors are opened
    TRY
        ${cnt}=         Get Length      ${S_DOORS}
        ${iDoor}=       set variable    ${0} 
        WHILE   True    limit=${cnt}
            ${out}=     RPS get Power       GetPower
            Should contain                  ${out}          ${S_DOORS[${iDoor}]}=0

            ${iDoor}=    set variable    ${iDoor+1}
        END
    EXCEPT    WHILE loop was aborted    type=start
        Log    The loop did not finish within ${iDoor}.
    END

Test all doors close
    TRY
        ${cnt}=     Get Length      ${S_DOORS}
        ${iDoor}=   set variable    ${0} 
        WHILE   True    limit=${cnt}
            ${out}=     RPS send commands    SetPower    ${S_DOORS[${iDoor}]}    1 
            #Log To Console    ${out} 
            Should be equal                 ${out}          ${True}
            #Log To Console    ${S_DOORS[${iDoor}]}
            ${iDoor}=    set variable    ${iDoor+1}
        END
    EXCEPT    WHILE loop was aborted    type=start
        Log    The loop did not finish within ${iDoor}.
    END

Test all doors are closed
    TRY
        ${cnt}=     Get Length      ${S_DOORS}
        ${iDoor}=   set variable    ${0} 
        WHILE   True    limit=${cnt}
            ${out}=     RPS get power    GetPower            
            #Log To Console    ${out}
            Should contain                  ${out}          ${S_DOORS[${iDoor}]}=1
            #Log To Console    ${S_DOORS[${iDoor}]}

            ${iDoor}=    set variable    ${iDoor+1}
        END
    EXCEPT    WHILE loop was aborted    type=start
        Log    The loop did not finish within ${iDoor}.
    END
