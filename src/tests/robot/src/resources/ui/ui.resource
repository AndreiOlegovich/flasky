*** Settings ***

Library  Browser
        ...  enable_playwright_debug=${True}
        ...  auto_closing_level=TEST
        ...  retry_assertions_for=0:00:03

*** Variables ***

${SERVER}        10.6.0.13:8080
${BROWSER}       Chromium
${WELCOME URL}   http://${SERVER}/
${LOGIN URL}     http://${SERVER}/login
${REGISTER URL}  http://${SERVER}/register
${USER URL}      http://${SERVER}/user 
${ERROR URL}     http://${SERVER}/error


*** Keywords ***

Start Chromium Browser
  New Browser  browser=chromium  headless=True
  New Context  viewport={'width': 1920, 'height': 1080}  ignoreHTTPSErrors=True


Open Browser To Login Page
    New Browser  browser=${BROWSER}  headless=True
    New Context  viewport={'width': 1920, 'height': 1080}  ignoreHTTPSErrors=True
    New Page    ${LOGIN URL}
    Login Page Should Be Open


Login Page Should Be Open
    Get Title  ==  Log In - Demo App


Input Username
    [Arguments]    ${username}
    Fill Text    //input[@id="username"]    ${username}


Input Password
    [Arguments]    ${password}
    Fill Text    //input[@id="password"]    ${password}


Input Firstname
    [Arguments]    ${firstname}
    Fill Text    //input[@id="firstname"]    ${firstname}


Input Lastname
    [Arguments]    ${lastname}
    Fill Text    //input[@id="lastname"]    ${lastname}


Input Phone
    [Arguments]    ${phone}
    Fill Text    //input[@id="phone"]    ${phone}


Submit Credentials
    Click    //input[@type="submit"]


User Page Should Be Open
    ${url}=  Get Url
    ${title}=  Get Title
    Should Be Equal    ${url}    ${USER URL}
    Should Be Equal    ${title}  User Information - Demo App


Open Browser To Register Page
    New Browser  browser=${BROWSER}  headless=True
    New Context  viewport={'width': 1920, 'height': 1080}  ignoreHTTPSErrors=True
    New Page    ${Register URL}
    Register Page Should Be Open


Register Page Should Be Open
    Get Title  ==  Register - Demo App
    Get Url  ==  ${REGISTER URL}


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

