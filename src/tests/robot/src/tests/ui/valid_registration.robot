*** Settings ***

Documentation     A test suite with tests for valid login.

Resource    ui/ui.resource
Resource    users/users.resource

Suite Setup  Setup Suite

Force Tags  ui


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


*** Test Cases ***

Valid Registration
    [Tags]  flasky
    Register User  user=${unique_user}
    Login Page Should Be Open
