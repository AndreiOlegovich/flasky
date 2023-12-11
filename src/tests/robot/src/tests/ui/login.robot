*** Settings ***

Documentation  Flasky App Login Data-driven Test
...            with [Template] TC Setting
Resource  users/users.resource

Suite Setup  Setup Suite

Force Tags    ui    login


*** Variables ***

*** Keywords ***

Create Unique User
    &{unique_user}=  Generate Unique User
    Set Suite Variable  ${unique_user}

Setup Suite
    Create Unique User
    Register User  user=${unique_user}

Test Setup Tasks
    Start Chromium Browser

Test Teardown Tasks
    Close Browser

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
