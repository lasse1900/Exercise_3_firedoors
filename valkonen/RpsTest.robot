*** Variables ***
${ENDPOINT} =   http://localhost:5000/PinState
${USERNAME} =   admin
${PASSWORD} =   12345678

*** Settings ***
Library      RpsTest.py  ${ENDPOINT}

*** Keywords ***
Set Pin State
    [Arguments]  ${pin}  ${state}
    ${status_code} =  Set Pin State With Username  ${USERNAME}  ${PASSWORD}  ${pin}  ${state}
    Should Be Equal    ${status_code}  OK

Pin State Should Be
    [Arguments]  ${pin}  ${state}
    ${data} =         Get Pin State With Username  ${USERNAME}  ${PASSWORD}
    Should Contain    ${data}  ${pin}
    Should Be Equal   ${data}[${pin}]  ${state}

*** Test Cases ***
Cannot Get State With Invalid Credentials
    ${response1} =         Get Pin State With Username  sfdff  ${PASSWORD}
    ${response2} =         Get Pin State With Username  ${USERNAME}  gf98hf8
    Should Be Equal     ${response1}  Access Denied
    Should Be Equal     ${response2}  Access Denied

Cannot Set State With Invalid Credentials
    ${response1} =         Set Pin State With Username  sfdff  ${PASSWORD}  PIN1  1
    ${response2} =         Set Pin State With Username  ${USERNAME}  gf98hf8  PIN  1
    Should Be Equal     ${response1}  Access Denied
    Should Be Equal     ${response2}  Access Denied

Turn On All Pins
    Set Pin State  P1  1
    Set Pin State  P2  1
    Set Pin State  P3  1
    Set Pin State  P4  1

Verify All Pins Are On
    Pin State Should Be   P1  1
    Pin State Should Be   P2  1
    Pin State Should Be   P3  1
    Pin State Should Be   P4  1

Turn Off All Pins
    Set Pin State  P1  0
    Set Pin State  P2  0
    Set Pin State  P3  0
    Set Pin State  P4  0

Verify All Pins Are Off
    Pin State Should Be   P1  0
    Pin State Should Be   P2  0
    Pin State Should Be   P3  0
    Pin State Should Be   P4  0