# How to run these tests

1. run 

```
make test
```

2. Wait for container intro and run

```
make test
```


# setup env

docker-compose build
docker-compose up -d

## access outside of container

http://localhost:8082

## access inside container

http://10.6.0.13:8080


# flasky

Should start automatically. If needed container can be accessed with
```
docker exec -it flasky_flasky_1 sh
```

Manually initialize DB
```
flask init-db 
```

Manually start app
```
flask run --host 0.0.0.0 --port 8080
```

# test
```
docker exec -it flasky_pytest_robot_ubuntu

robot --include shui tests/robot/src/tests/ui/ui_test_page.robot

python -m pytest tests/pytest/src/tests/flasky/
```

# results 

1. Original requiremenst are outdated.
For compatibility with Python 3.10
more recent versions are required

2. Container with Flask is based on alpine with sh, so
shebang in run.sh

```
#!/bin/bash
```
 is incorrect and should be replaced with 
```
#!/bin/sh
```
 or bash should be installed

3. CMD in Dockerfile looks useless.
Used command in docker-compose.yml instead.

4. Bug

api/users url is replying without proper authentication

5. Possible Bug (WIP)

Creating users with POST to api/users 
and updating with PUT api/users/username are not working 
(probably error somewhere in testing code)
