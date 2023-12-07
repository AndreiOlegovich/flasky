*** Settings ***

Documentation     A test suite with tests for invalid login.
...               User tries to login without some credential.
...               It is verified that user stays on the Register
...               Page and doesn't proceed to Login Page

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

Without Username
    [Tags]  flasky    proto
    ${spoiled_user}=  User Without Username
    Register User  user=${spoiled_user}
    Register Page Should Be Open


Without Password
    [Tags]  flasky
    ${spoiled_user}=  User Without Password
    Register User  user=${spoiled_user}
    Register Page Should Be Open


Without First Name
    [Tags]  flasky
    ${spoiled_user}=  User Without First Name
    Register User  user=${spoiled_user}
    Register Page Should Be Open


Without Last Name
    [Tags]  flasky
    ${spoiled_user}=  User Without Last Name
    Register User  user=${spoiled_user}
    Register Page Should Be Open


Without Phone Number
    [Tags]  flasky
    ${spoiled_user}=  User Without Phone Number
    Register User  user=${spoiled_user}
    Register Page Should Be Open


Without Multiple Credentials
    [Tags]  flasky  proto
    ${spoiled_user}=  User Without Multiple Credentials  username  password
    Register User  user=${spoiled_user}
    Register Page Should Be Open
    ${spoiled_user}=  User Without Multiple Credentials
    Register User  user=${spoiled_user}
    Register Page Should Be Open
