docker system prune
docker rm $(docker ps -aq)
docker rmi $(docker images -q)
docker system prune