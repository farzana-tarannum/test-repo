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

runsqlfile() {
	docker exec --interactive --tty db1 psql --host 192.168.2.146 --port 5432 --username eagle --dbname hawk  < $2
#	docker exec --interactive --tty db1 psql --username eagle --dbname hawk  < $2
}

post_forwards() {
	docker port db1
	docker inspect db1 | grep IPAddress
	docker ps | awk '{print $1}' | xargs docker inspect --format '{{ .NetworkSettings.IPAddress }}'
	docker inspect --format '{{ .NetworkSettings.IPAddress }}' $(docker ps -q)
}

stop() {
	# docker exec to container id 32d3b3e2b2e3
	#
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
	docker exec -it db1 psql -U eagle -d hawk -c "SELECT datname FROM pg_database limit 5;"
	docker exec -it db1 psql -U eagle -d hawk -c "SELECT usename FROM pg_user limit 5;"
	docker exec -it db1 psql -U eagle -d hawk -c "SELECT tablename FROM pg_tables limit 5;"
	docker exec -it db1 psql -U eagle -d hawk -c "SELECT rolname FROM pg_roles limit 5;"
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
	"sql")
		runsqlfile
		exit 0
		;;
	*)
		start
		exit 0
		;;
esac
