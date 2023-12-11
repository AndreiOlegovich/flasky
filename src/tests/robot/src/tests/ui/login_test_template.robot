*** Settings ***

Documentation  Flasky App Login Data-driven Test with
...            Arguments Embedded to Template Keyword Name
...            and Test Template Setting demo
Resource  users/users.resource

Suite Setup  Setup Suite

Force Tags    ui    login

Test Template    Providing ${username} and ${password} Title Should Be ${expected}


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

With Valid Credentials
    ${unique_user.username}    ${unique_user.password}    User Information - Demo App


With Invalid Credentials
    WRONG                      WRONG                      Login Failure - Demo App
    ${unique_user.username}    WRONG                      Login Failure - Demo App
    WRONG                      ${unique_user.password}    Login Failure - Demo App


With Missing Credentials
    ${EMPTY}                   ${EMPTY}                   Log In - Demo App
    ${unique_user.username}    ${EMPTY}                   Log In - Demo App
    ${EMPTY}                   ${unique_user.password}    Log In - Demo App
    WRONG                      ${EMPTY}                   Log In - Demo App
    ${EMPTY}                   WRONG                      Log In - Demo App
