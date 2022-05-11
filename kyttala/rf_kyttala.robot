*** Settings ***
Library    lib/commands.py

# TODO delay function & time measurement
# TODO using loop to change statges

*** Variables ***
@{PINS}=    ['P60', 'P61', 'P62', 'P63', 'P64','P65']

*** Test Cases ***
Loop for each pin
    FOR    ${item}    IN    @{PINS}
        Log    ${item}
    END

Turn on Power to transient state on all supplies remotely
     ${out}=    RPS send commands     SetPower  0  0.5
     ${out}=    RPS send commands     SetPower  1  0.5
     ${out}=    RPS send commands     SetPower  2  0.5
     ${out}=    RPS send commands     SetPower  3  0.5
     ${out}=    RPS send commands     SetPower  4  0.5
     ${out}=    RPS send commands     SetPower  5  0.5


Verify power is in transient stage on all supplies
    ${out}=     RPS get power    GetPower
    should contain    ${out}  P60=0.5
    should contain    ${out}  P61=0.5
    should contain    ${out}  P62=0.5
    should contain    ${out}  P63=0.5
    should contain    ${out}  P64=0.5
    should contain    ${out}  P65=0.5

Turn on Power on all supplies remotely
    ${out}=    RPS send commands     SetPower  0  1
    ${out}=    RPS send commands     SetPower  1  1
    ${out}=    RPS send commands     SetPower  2  1
    ${out}=    RPS send commands     SetPower  3  1
    ${out}=    RPS send commands     SetPower  4  1
    ${out}=    RPS send commands     SetPower  5  1

Verify power is turned-on on all supplies
    ${out}=     RPS get power    GetPower
    should contain    ${out}  P60=1
    should contain    ${out}  P61=1
    should contain    ${out}  P62=1
    should contain    ${out}  P63=1
    should contain    ${out}  P64=1
    should contain    ${out}  P65=1

*** Keywords ***
RPS send commands
    [Arguments]    ${command}    ${port}    ${state}
    ${output}=    Send cmds    ${command}  ${port}  ${state}
    [return]    ${output}

RPS get Power
    [Arguments]    ${command}
    ${output}=    Send cmds    ${command}
    [return]    ${output}