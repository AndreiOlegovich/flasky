*** Settings ***

Documentation  Flasky App UI Test
Resource  ui/ui.resource
Resource  users/users.resource

Library  utils.py

Suite Setup  Setup Suite

Test Tags  ui  login


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


*** Test Cases ***

Missing Username
    [Documentation]    Username field is left empty
    [Tags]  flasky
    Open Browser To Login Page  
    Input Password    ${unique_user.password}
    Submit Credentials
    Login Page Should Be Open

Missing Password
    [Documentation]    Password field is left empty
    [Tags]  flasky
    Open Browser To Login Page  
    Input Username    ${unique_user.username}
    Submit Credentials
    Login Page Should Be Open

Missing Credentials
    [Documentation]
    ...    Empty strings are used
    ...    for username and password
    [Tags]  flasky
    Open Browser To Login Page  
    Submit Credentials
    Login Page Should Be Open

Wrong Username
    [Documentation]
    ...    Wrong username based on random
    ...    string is used for username
    [Tags]  flasky
    Open Browser To Login Page
    ${wrong_username}=  Unique Username
    Input Username    ${wrong_username}
    Input Password    ${unique_user.password}
    Submit Credentials
    Error Page Should Be Open

Wrong Password
    [Documentation]    Random string is used for password
    [Tags]  flasky
    Open Browser To Login Page
    ${wrong_password}=  Str Uuid
    Input Username    ${unique_user.username}
    Input Password    ${wrong_password}
    Submit Credentials
    Error Page Should Be Open

Wrong Credentials
    [Documentation]
    ...    Wrong username based on random
    ...    string is used for username.
    ...    Random string is used for password
    [Tags]  flasky
    Open Browser To Login Page
    ${wrong_username}=  Unique Username
    ${wrong_password}=  Str Uuid
    Input Username    ${wrong_username}
    Input Password    ${wrong_password}
    Submit Credentials
    Error Page Should Be Open
