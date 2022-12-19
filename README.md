# setup env

docker-compose build
docker-compose up -d

## access outside of container

http://localhost:8082

## access inside container

http://10.6.0.13:8080


# flasky

docker exec -it flasky_flasky_1 sh
flask init-db
flask run --host 0.0.0.0 --port 8080


# test

docker exec -it flasky_pytest_robot_ubuntu
robot --include shui tests/robot/src/tests/ui/ui_test_page.robot
python -m pytest tests/pytest/src/tests/flasky/


# results 

Original requiremenst are outdated.
For compatibility with Python 3.10
more recent versions are required

api/users url is replying without proper authentication
