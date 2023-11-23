*** Settings ***

Documentation  Create and Manage Users

Library  utils.py

*** Variables ***

*** Keywords ***

Unique Username
    ${username}=  Catenate  Username  Str Uuid
    [Return]  ${username}


Generate Unique User
    &{user}=  Generate User
    [Return]  &{user}
