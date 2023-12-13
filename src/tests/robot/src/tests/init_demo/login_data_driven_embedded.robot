*** Settings ***

Documentation  Flasky App Login Data-driven Test with
...            Arguments Embedded to Keyword Name and
...            Named Columns
Resource  users/users.resource

Test Tags    login


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

*** Test Cases ***

Login With Credentials
    [Documentation]    A test case that covers both
    ...                valid, invalid and missing
    ...                credentials entry
    [Template]    Providing ${username} and ${password} Title Should Be ${expected}
    ${unique_user.username}    ${unique_user.password}    User Information - Demo App
    WRONG                      WRONG                      Login Failure - Demo App
    ${unique_user.username}    WRONG                      Login Failure - Demo App
    WRONG                      ${unique_user.password}    Login Failure - Demo App
    ${EMPTY}                   ${EMPTY}                   Log In - Demo App
    ${unique_user.username}    ${EMPTY}                   Log In - Demo App
    ${EMPTY}                   ${unique_user.password}    Log In - Demo App
    WRONG                      ${EMPTY}                   Log In - Demo App
    ${EMPTY}                   WRONG                      Log In - Demo App
