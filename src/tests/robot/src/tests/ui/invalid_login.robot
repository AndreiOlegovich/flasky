*** Settings ***

Documentation  Flasky App UI Test
Resource  ui/ui.resource
Resource  users/users.resource

Suite Setup  Setup Suite

Force Tags  ui


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
    [Tags]  flasky
    Open Browser To Login Page  
    Input Password    ${unique_user.password}
    Submit Credentials
    Login Page Should Be Open

Missing Password
    [Tags]  flasky
    Open Browser To Login Page  
    Input Username    ${unique_user.username}
    Submit Credentials
    Login Page Should Be Open

Missing Credentials
    [Tags]  flasky
    Open Browser To Login Page  
    Submit Credentials
    Login Page Should Be Open
