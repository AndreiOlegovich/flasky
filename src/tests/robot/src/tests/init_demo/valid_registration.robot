*** Settings ***

Documentation     A test suite with tests for valid login.

Resource    ui/ui.resource
Resource    users/users.resource

Suite Setup  Create Unique User

Test Tags  register


*** Variables ***

*** Keywords ***

Create Unique User
    &{unique_user}=  Generate Unique User
    Set Suite Variable  ${unique_user}

Test Setup Tasks
    Start Chromium Browser

Test Teardown Tasks
    Close Browser


*** Test Cases ***

Valid Registration
    [Tags]  flasky
    Register User  user=${unique_user}
    Login Page Should Be Open
