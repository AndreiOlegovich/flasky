*** Settings ***

Documentation  Flasky App Login and
...            Registration Tests   

Resource    ui/ui.resource
Resource    users/users.resource

Suite Setup  Setup Suite

Test Tags    ui

*** Keywords ***

Setup Suite
    Create Unique User
    Register User  user=${unique_user}
    # To reduce variable names two new
    # variables are created here
    ${VALID USER}=  Set Variable  ${unique_user.username}
    Set Suite Variable  ${VALID USER}  children=True
    ${VALID PASSWD}=  Set Variable  ${unique_user.password} 
    Set Suite Variable  ${VALID PASSWD}  children=True

Create Unique User
    &{unique_user}=  Generate Unique User
    Set Suite Variable  ${unique_user}  children=True

Test Setup Tasks
    Start Chromium Browser

Test Teardown Tasks
    Close Browser