!/bin/bash

# Stop and remove all containers
# docker stop $(docker ps -a -q)
# docker rm $(docker ps -a -q)
# docker rmi $(docker images -q)
# docker volume rm $(docker volume ls -q)
# docker network rm $(docker network ls -q)
# docker system prune -a
# docker system prune --volumes
# docker system prune --all --volumes
# docker system prune --volume --all --force 
# docker system prune --all --volumes --force
# docker network ls 
# docker network rm $(docker network ls -q)
#
# docker network inspect bridge 
# docker network inspect host 
# docker container run -it --detach --rm --name my-nginx -p 8080:80 nginx
# docker container run -it --detach --rm --name my-nginx -p 8080:80 --network host nginx 
# docker container run -it --detach --rm --name my-nginx -p 8080:80 --network bridge nginx
# docker container run -it --detach --rm --name my-nginx -p 8080:80 --network none nginx
# docker container run -it --detach --rm --name my-nginx -p 8080:80 --network host nginx
# docker ps -q | xargs docker inspect --format '{{ .NetworkSettings.IPAddress }}'
# docker container run -it --detach --rm --name my-nginx -p 8080:80 --network host nginx
# docker inspect -f "{{ .volumes }}' 
# docker inspect -f "{{ .Mounts }}'
# docker inspect -f "{{ .Volumes }}'
#
# Mounts 
