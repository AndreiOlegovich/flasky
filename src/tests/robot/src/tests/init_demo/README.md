## __init__.robot files

[Official Docs](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#suite-initialization-files)



Test Tags are added to child test suites only if tests are run as a directory.

Documentation overwrites Documentations of child test suites not complementing them.

To be able to use Suite Setup all the necessary keywords should be written inside __init__.robot file or imported with Resource or Library.

Combining shared code to __init__.robot file may result in tests becoming unexecutable separately.
