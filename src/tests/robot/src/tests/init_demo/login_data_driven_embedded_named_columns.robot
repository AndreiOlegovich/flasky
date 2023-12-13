*** Settings ***

Documentation  Flasky App Login Data-driven Test with
...            Arguments Embedded to Keyword Name and
...            Named Columns
Resource  users/users.resource

Test Tags    login

Test Template    Providing ${username} and ${password} Title Should Be ${expected}


*** Variables ***

*** Keywords ***


Providing ${username} and ${password} Title Should Be ${expected}
    Open Browser To Login Page
    Log    ${username}
    Log    ${password}
    Input Username    ${username}
    Input Password    ${password}
    Submit Credentials
    ${title}=  Get Title
    Log    ${title}
    Should Be Equal    ${title}    ${expected}


*** Test Cases ***                  USERNAME         PASSWORD           EXPECTED TITLE
Valid Credentials                   ${VALID USER}    ${VALID PASSWD}    User Information - Demo App
Invalid User Name                   invalid          ${VALID PASSWD}    Login Failure - Demo App
Invalid Password                    ${VALID USER}    invalid            Login Failure - Demo App
Invalid User Name and Password      invalid          invalid            Login Failure - Demo App
Empty User Name                     ${EMPTY}         ${VALID PASSWD}    Log In - Demo App
Empty Password                      ${VALID USER}    ${EMPTY}           Log In - Demo App
Empty User Name and Password        ${EMPTY}         ${EMPTY}           Log In - Demo App
Empty User Name Invalid Password    ${EMPTY}         invalid            Log In - Demo App
Invalid User Name Empty Password    invalid          ${EMPTY}           Log In - Demo App
