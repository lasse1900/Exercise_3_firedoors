*** Settings ***
Library      commands.py

*** Variables ***
@{S_DOORS}=    sd1    sd2    sd3    sd4    #It is a good practice to have a list of INTs instead

*** Keywords ***
#BuiltIn .

RPS set Power
    [Arguments]                         ${command}      ${port}     ${state}
    ${output}=      send_cmds           ${command}      ${port}     ${state}    # ref. to //send_cmds(self, cmd, port=None, state=None)// from the library
    [return]                            ${output}

### The previous is basically the syntax used by Robot, in python in would be like: ###
# def rpsSetPower(command, port, state):
#    out = send_cmds(command, port, state)
#    return out

RPS get Power
    [Arguments]                         ${command}
    ${output}=      send_cmds           ${command}
    [return]                            ${output}

*** Test Cases ***
Test all doors open
    TRY
        ${cnt}=         Get Length      ${S_DOORS}
        ${iDoor}=       set variable    ${0} 
        WHILE   True    limit=${cnt}
            ${out}=     RPS set Power       SetPower        ${S_DOORS[${iDoor}]}    0  
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
            ${out}=     RPS set Power       SetPower        ${S_DOORS[${iDoor}]}    1 
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
            ${out}=     RPS get Power       GetPower
            #Log To Console    ${out}
            Should contain                  ${out}          ${S_DOORS[${iDoor}]}=1
            #Log To Console    ${S_DOORS[${iDoor}]}

            ${iDoor}=    set variable    ${iDoor+1}
        END
    EXCEPT    WHILE loop was aborted    type=start
        Log    The loop did not finish within ${iDoor}.
    END

