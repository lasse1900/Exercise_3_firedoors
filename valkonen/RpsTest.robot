*** Variables ***
${ENDPOINT} =   http://localhost:5000/PinState
${USERNAME} =   admin
${PASSWORD} =   12345678
${ON} =         ${1}
${OFF} =        ${0}

*** Settings ***
Library      lib/RpsTest.py  ${ENDPOINT}

*** Keywords ***
Set Pin State
    [Arguments]  ${pin}  ${state}
    ${result} =  Set Pin State With Username  ${USERNAME}  ${PASSWORD}  ${pin}  ${state}
    Should Be Equal    ${result}  OK

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
    ${response1} =         Set Pin State With Username  sfdff  ${PASSWORD}  PIN1  ${ON}
    ${response2} =         Set Pin State With Username  ${USERNAME}  gf98hf8  PIN  ${ON}
    Should Be Equal     ${response1}  Access Denied
    Should Be Equal     ${response2}  Access Denied

Turn On All Pins
    Set Pin State  P1  ${ON}
    Set Pin State  P2  ${ON}
    Set Pin State  P3  ${ON}
    Set Pin State  P4  ${ON}

Verify All Pins Are On
    Pin State Should Be   P1  ${ON}
    Pin State Should Be   P2  ${ON}
    Pin State Should Be   P3  ${ON}
    Pin State Should Be   P4  ${ON}

Turn Off All Pins
    Set Pin State  P1  ${OFF}
    Set Pin State  P2  ${OFF}
    Set Pin State  P3  ${OFF}
    Set Pin State  P4  ${OFF}

Verify All Pins Are Off
    Pin State Should Be   P1  ${OFF}
    Pin State Should Be   P2  ${OFF}
    Pin State Should Be   P3  ${OFF}
    Pin State Should Be   P4  ${OFF}