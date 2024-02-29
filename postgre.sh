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

## shell functions 
start() {
	echo "Starting up postgre server ..."
	docker inspect db1 &> /dev/null &&  echo "containter down" && docker start db1 || \
	docker run --detach --name db1 --publish 5432:5432 --volume \
		/home/rusty/db1:/var/lib/postgresql/data \
		--env POSTGRES_PASSWORD=0n3p4ssw0rd \
		--env POSTGRES_USER=eagle --env POSTGRES_DB=hawk \
		postgres:latest
}

stop() {
	echo "stopping container"
	docker stop db1
}	

clean() {

	if [ "$(docker ps --all --quiet --filter name=db1)" ]; then
	echo "removing container"
	docker rm db1
	fi
}

health() {
	echo "checking container health"
	docker inspect db1 &> /dev/null &&  echo "containter up" || echo "containter down"
}

dbhealth() {
	if [ "$(docker ps -q -f name=db1)" ]; then
	echo "containter up"
	docker exec -it db1 psql -U eagle -d hawk -c "SELECT 'Hello, world!';"
	docker exec --interactive --tty db1 psql --username eagle --dbname hawk \
		-c "SELECT version();"
	docker exec -it db1 psql -U eagle -d hawk -c "SELECT datname FROM pg_database;"
	docker exec -it db1 psql -U eagle -d hawk -c "SELECT * FROM pg_user;"
	docker exec -it db1 psql -U eagle -d hawk -c "SELECT tablename FROM pg_tables;"
	docker exec -it db1 psql -U eagle -d hawk -c "SELECT rolname FROM pg_roles;"
	fi 
}

case $1 in 
	"down")
		stop
		exit 0
		;;
	
	"clean")
		clean
		exit 0
		;;
	"db")
		dbhealth
		exit 0
		;;
	"health")
		health
		docker ps -a	
		exit 0
		;;
	*)
		start
		exit 0
		;;
esac
