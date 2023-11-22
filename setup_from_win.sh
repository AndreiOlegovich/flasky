
dos2unix ./Flasky-master/run.sh
docker compose build
docker compose up -d
docker exec -it flasky_pytest_robot_ubuntu bash

