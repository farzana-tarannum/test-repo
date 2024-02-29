#!/bin/bash 
# This script will run the postgre server in docker container
# where /home/rusty/db1 would be the location of the database files
# mapped to the volume /var/lib/postgresql/data
# will map the port 5432 to 5432
# will use the postgres:latest image 
# will use the container name db1 

# Run the postgre server in docker container
#
d=/home/rusty/db1
if [ ! -d /home/rusty/db1 ]; then
	echo "directory not found creating directory"
	mkdir $d 
else 
	echo "volume dir $d found"
fi


if [ "$(docker ps -q -f name=db1)" ]; then
	echo "containter up"
docker exec -it db1 psql -U eagle -d hawk -c "SELECT 'Hello, world!';"
docker exec --interactive --tty db1 psql --username eagle --dbname hawk \
	-c "SELECT version();"
docker exec -it db1 psql -U eagle -d hawk -c "SELECT datname FROM pg_database;"
docker exec -it db1 psql -U eagle -d hawk -c "SELECT * FROM pg_user;"
docker exec -it db1 psql -U eagle -d hawk -c "SELECT tablename FROM pg_tables;"
docker exec -it db1 psql -U eagle -d hawk -c "SELECT rolname FROM pg_roles;"

	if [ "$1" == "down" ]; then
		echo "stopping container"
		docker stop db1
	fi
	exit 0
else 
	echo "container down"
fi 

if [ "$(docker ps --all --quiet --filter name=db1)" ] && [ "$1" == "clean" ]; then
	echo "removing container"
	docker rm db1
fi


echo "Starting up postgre server ..."
	
docker inspect db1 &> /dev/null &&  echo "containter down" && docker start db1 || \
docker run --detach --name db1 --publish 5432:5432 --volume \
	/home/rusty/db1:/var/lib/postgresql/data \
	--env POSTGRES_PASSWORD=0n3p4ssw0rd \
	--env POSTGRES_USER=eagle --env POSTGRES_DB=hawk \
	postgres:latest

# &> directs both standard output and standard error to /dev/null
# && is used to run the next command if the previous command is successful
# || is used to run the next command if the previous command is not successful
#
#
