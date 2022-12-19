*** Settings ***
Documentation  Example that opens single page

Library  Browser
        ...  enable_playwright_debug=${True}
        ...  auto_closing_level=TEST
        ...  retry_assertions_for=0:00:03
Library  Collections

Force Tags  ui


*** Variables ***

${url}  http://10.6.0.13:8080
&{test_user0}=  username=tester0  password=secret0  firstname=Dmitry  lastname=Mendeleev  phone=012345
&{test_user1}=  username=tester1  password=secret1  firstname=Nikolai  lastname=Basov  phone=012346

${user}=  User1


*** Keywords ***

Test Setup Tasks
  Start Chromium Browser

Test Teardown Tasks
  Close Browser

Start Chromium Browser
  New Browser  browser=chromium  headless=True
  New Context  viewport={'width': 1920, 'height': 1080}  ignoreHTTPSErrors=True


*** Test Cases ***


Check Tester
  [Tags]  tester
  Log To Console  ${user}
  Log To Console  ${test_user0}  
  Should Be Equal  ${test_user0.username}  tester0
  Should Be Equal  ${test_user0.password}  secret
  Should Be Equal  ${test_user0.firstname}  Dmitry
  Should Be Equal  ${test_user0.lastname}  Mendeleev
  Should Be Equal  ${test_user0.phone}  012345
  


Register Button Works
  [Tags]  reg
  New Page  ${url}
  #  ${reg_button}=    Get Elements  text="Register"
  Click  text="Register"
  Get Title  ==  Register - Demo App


Register User
  [Tags]  reg
  New Page  ${url}
  Click  text="Register"
  Get Title  ==  Register - Demo App
  Fill Text  //input[@id="username"]    ${test_user0.username}
  Fill Text  //input[@id="password"]    ${test_user0.password}
  Fill Text  //input[@id="firstname"]    ${test_user0.firstname}
  Fill Text  //input[@id="lastname"]    ${test_user0.lastname}
  Fill Text  //input[@id="phone"]    ${test_user0.phone}
  Click    //input[@type="submit"]
  Get Title  ==  Log In - Demo App


User Can Not Be Registered With Existing Username
  [Tags]  reg
  New Page  ${url}
  Click  text="Register"
  Get Title  ==  Register - Demo App
  Fill Text  //input[@id="username"]    ${test_user0.username}
  Fill Text  //input[@id="password"]    a
  Fill Text  //input[@id="firstname"]    b
  Fill Text  //input[@id="lastname"]    c
  Fill Text  //input[@id="phone"]    67890
  Click    //input[@type="submit"]
  Get Title  !=  Log In - Demo App




User Can Login With Correct Password
  [Tags]  reg
  New Page  ${url}
  Click  text="Log In"
  Get Title  ==  Log In - Demo App
  Fill Text  //input[@id="username"]    ${test_user0.username}
  Fill Text  //input[@id="password"]    ${test_user0.password}
  Click    //input[@type="submit"]
  Get Title  ==  User Information - Demo App

  

User Can Login After Registration With Correct Password 
  [Tags]  reg
  New Page  ${url}
  #  ${reg_button}=    Get Elements  text="Register"
  Click  text="Register"
  Get Title  ==  Register - Demo App
  Fill Text  //input[@id="username"]    ${test_user1.username}
  Fill Text  //input[@id="password"]    ${test_user1.password}
  Fill Text  //input[@id="firstname"]    ${test_user1.firstname}
  Fill Text  //input[@id="lastname"]    ${test_user1.lastname}
  Fill Text  //input[@id="phone"]    ${test_user1.phone}
  Click    //input[@type="submit"]
  Get Title  ==  Log In - Demo App
  Fill Text  //input[@id="username"]    ${test_user1.username}
  Fill Text  //input[@id="password"]    ${test_user1.password}
  Click    //input[@type="submit"]
  Get Title  ==  User Information - Demo App


User Can Not Login With Incorrect Password
  [Tags]  reg
  New Page  ${url}
  Click  text="Log In"
  Get Title  ==  Log In - Demo App
  Fill Text  //input[@id="username"]    ${test_user0.username}
  Fill Text  //input[@id="password"]    ${test_user1.password}
  Click    //input[@type="submit"]
  Get Title  ==  Login Failure - Demo App


User Information Is Correct
  [Tags]  reg
  New Page  ${url}
  Click  text="Log In"
  Get Title  ==  Log In - Demo App
  Fill Text  //input[@id="username"]    ${test_user0.username}
  Fill Text  //input[@id="password"]    ${test_user0.password}
  Click    //input[@type="submit"]
  Get Title  ==  User Information - Demo App

  ${username}=    Get Element    //td[@id="username"]
  Get Text    ${username}    ==    ${test_user0.username}
  ${firstname}=    Get Element    //td[@id="firstname"]
  Get Text    ${firstname}    ==    ${test_user0.firstname}
  ${lastname}=    Get Element    //td[@id="lastname"]
  Get Text    ${lastname}    ==    ${test_user0.lastname}
  ${phone}=    Get Element    //td[@id="phone"]
  Get Text    ${phone}    ==    ${test_user0.phone}

