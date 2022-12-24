PHONY: test
test:
	docker-compose build
	docker-compose up -d
	docker exec -it flasky_pytest_robot_ubuntu bash

PHONY: rmdb
rmdb:
	-docker stop flasky_flasky_1
	sudo rm Flasky-master/instance/demo_app.sqlite
	docker-compose up -d




