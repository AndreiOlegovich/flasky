*** Settings ***

Documentation  Flasky App UI Test
Resource  ui/ui.resource
Resource  users/users.resource


Library  Collections
Library  OperatingSystem

Suite Setup  Prepare Variables

Force Tags  ui


*** Variables ***

${user}  User


# ${url}=  http://10.6.0.13:8080


*** Keywords ***

Test Setup Tasks
    Start Chromium Browser

Test Teardown Tasks
    Close Browser

Prepare Variables
  ${unique_username}=  Unique Username
  &{unique_user}=  Generate Unique User
  Set Suite Variable  ${unique_user}
  ${path}=  Normalize path  ${CURDIR}/../../../../test_data/users.json
  ${json}=  Get File  ${path}
  ${object}=  Evaluate  json.loads('''${json}''')  json
  ${url}=  Convert To String  ${object["url"]}
  Set Suite Variable  ${url}
  &{test_user0}=  Convert To Dictionary  ${object["users"][0]}
  Set Suite Variable  ${test_user0}
  ${test_user0_phone_str}=  Convert To String  ${test_user0.phone}
  Set Suite Variable  ${test_user0_phone_str}
  &{test_user1}=  Convert To Dictionary  ${object["users"][1]}
  Set Suite Variable  ${test_user1}

Fill Form
  [Arguments]
  ...  ${text}
  ...  ${username}
  ...  ${password}
  ...  ${firstname}
  ...  ${lastname}
  ...  ${phone}
  # ...  ${expected_title}
  New Page  ${url}
  Click  text=${text}
  Fill Text  //input[@id="username"]    ${username}
  Fill Text  //input[@id="password"]    ${password}
  Fill Text  //input[@id="firstname"]    ${firstname}
  Fill Text  //input[@id="lastname"]    ${lastname}
  Fill Text  //input[@id="phone"]    ${phone}
  Click    //input[@type="submit"]
  

*** Test Cases ***

Check Tester
  [Tags]  health
  Log To Console    ${user}
  Log To Console    ${test_user0}  
  Should Be Equal    ${test_user0.username}  tester0
  Should Be Equal    ${test_user0.password}  secret0
  Should Be Equal    ${test_user0.firstname}  Dmitry
  Should Be Equal    ${test_user0.lastname}  Mendeleev
  Should Be Equal As Integers    ${test_user0.phone}    12345
  

Register Button Works
  [Tags]  flasky
  New Page  ${url}
  Click  text="Register"
  Get Title  ==  Register - Demo App


Register Unique User
  [Tags]  flasky  uniq
  New Page  ${url}
  Click  text="Register"
  Get Title  ==  Register - Demo App
  Fill Text  //input[@id="username"]    ${unique_user.username}
  Fill Text  //input[@id="password"]    ${unique_user.password}
  Fill Text  //input[@id="firstname"]    ${unique_user.firstname}
  Fill Text  //input[@id="lastname"]    ${unique_user.lastname}
  Fill Text  //input[@id="phone"]    ${unique_user.phone}
  Click    //input[@type="submit"]
  Get Title  ==  Log In - Demo App


Register User
  [Tags]  flasky 
  #[Template]  Fill Form
  #text="Register"
  #...  username=${test_user0.username}
  #...  password=${test_user0.password}  
  #...  firstname=${test_user0.firstname}  lastname=${test_user0.lastname}  
  #...  phone=${test_user0.phone}  
  # ...  expected_title=Log In - Demo App
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
  [Tags]  flasky
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


Valid Login
  [Tags]  flasky
  Open Browser To Login Page
  Input Username    ${unique_user.username}
  Input Password    ${unique_user.password}
  Submit Credentials
  User Page Should Be Open
  


User Can Login With Correct Password
  [Tags]  flasky
  New Page  ${url}
  Click  text="Log In"
  Get Title  ==  Log In - Demo App
  Fill Text  //input[@id="username"]    ${test_user0.username}
  Fill Text  //input[@id="password"]    ${test_user0.password}
  Click    //input[@type="submit"]
  Get Title  ==  User Information - Demo App
  

User Can Login After Registration With Correct Password 
  [Tags]  flasky
  New Page  ${url}
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
  [Tags]  flasky
  New Page  ${url}
  Click  text="Log In"
  Get Title  ==  Log In - Demo App
  Fill Text  //input[@id="username"]    ${test_user0.username}
  Fill Text  //input[@id="password"]    ${test_user1.password}
  Click    //input[@type="submit"]
  Get Title  ==  Login Failure - Demo App


User Information Is Correct
  [Tags]  flasky
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
  Get Text    ${phone}    ==    ${test_user0_phone_str}
