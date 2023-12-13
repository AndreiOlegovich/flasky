*** Settings ***

Documentation     A test suite with tests for valid login.

Resource    ui/ui.resource
Resource    users/users.resource

Suite Setup  Setup Suite

Test Tags  login


*** Variables ***

*** Keywords ***

Test Setup Tasks
    Start Chromium Browser

Test Teardown Tasks
    Close Browser

Create Unique User
    &{unique_user}=  Generate Unique User
    Set Suite Variable  ${unique_user}

Setup Suite
    Create Unique User
    Register User  user=${unique_user}


*** Test Cases ***

Valid Login
    [Tags]  flasky
    Open Browser To Login Page  
    Input Username    ${unique_user.username}
    Input Password    ${unique_user.password}
    Submit Credentials
    User Page Should Be Open
