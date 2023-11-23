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
    ${title}=  Get Title
    Should Be Equal    ${title}    Log In - Demo App


Input Username
    [Arguments]    ${username}
    Fill Text    //input[@id="username"]    ${username}


Input Password
    [Arguments]    ${password}
    Fill Text    //input[@id="password"]    ${password}


Submit Credentials
    Click    //input[@type="submit"]


User Page Should Be Open
    ${url}=  Get Url
    ${title}=  Get Title
    Should Be Equal    ${url}    ${USER URL}
    Should Be Equal    ${title}  User Information - Demo App