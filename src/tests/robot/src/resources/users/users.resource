*** Settings ***

Documentation  Create and Manage Users

Library  users.py
Resource  ui/ui.resource

*** Variables ***

*** Keywords ***

Unique Username
    ${username}=  Catenate  Username  Str Uuid
    [Return]  ${username}


Generate Unique User
    &{user}=  Generate User
    [Return]  &{user}


User Without Username
    &{user}=  Generate User
    &{spoiled_user}=  Spoil User  ${user}  username
    [Return]  &{spoiled_user}


User Without Password
    &{user}=  Generate User
    &{spoiled_user}=  Spoil User  ${user}  password
    [Return]  &{spoiled_user}


User Without First Name
    &{user}=  Generate User
    &{spoiled_user}=  Spoil User  ${user}  firstname  
    [Return]  &{spoiled_user}


User Without Last Name
    &{user}=  Generate User
    &{spoiled_user}=  Spoil User  ${user}  lastname
    [Return]  &{spoiled_user}


User Without Phone Number
    &{user}=  Generate User
    &{spoiled_user}=  Spoil User  ${user}  phone
    [Return]  &{spoiled_user}


User Without Multiple Credentials
    [Arguments]  @{missing_creds}

    ${list_len}=    Get Length    ${missing_creds}
    IF  ${list_len} == 0
        @{missing_creds}=  Select Credentials To Delete
    END

    &{user}=  Generate User
    &{spoiled_user}=  Spoil User    ${user}    ${missing_creds}
    [Return]  &{spoiled_user}


Register User
    [Arguments]    ${user}
    Open Browser To Register Page
    Input Username  ${user.username}
    Log  ${user.username}
    Input Password  ${user.password}
    Input Firstname  ${user.firstname}
    Input Lastname  ${user.lastname}
    Input Phone  ${user.phone}
    Submit Credentials
