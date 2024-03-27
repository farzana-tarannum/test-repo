#!/bin/sh 
# Start the PostgreSQL server
#
docker container run --name postgres --env POSTGRES_PASSWORD=postgres --remove-orphan \
	--env POSTGRES_USER=postgres --env POSTGRES_DB=postgres \
	--detach -p 5432:5432 postgres:alpine --volume \
	/home/rusty/posgredocker:/var/lib/postgresql/data \
	postgres:alpine

docker container ps
docker container logs postgres
# docker run --name go --rm -it -v /home/rusty/go:/go golang:alpine bash :/go
# on the host machin
# psql -h localhost -U postgres -d postgres
docker container exec -it postgres psql -U postgres -d postgres -c "SELECT versoin();"
docker container exec -it postgres psql -U postgres -C "CREATE DATABASE mydb;"
docker container exec -it postgres psql -U posgres -C "CREATE USER myuser WITH PASSWORD 'mypass';"
docker container exec -it postgres psql -U postgres -C "GRANT ALL PRIVILEGES ON DATABASE mydb TO myuser;"
docker container exec -it postgres psql -U myuser -d mydb -c "CREATE TABLE mytalbe (id serial PRIMARY KEY,\
	name VARCHAR(50));"
docker container exec -it postgres psql -U myuer -d mydb
# INSERT INTO mytable (name) VALUES ('Rusty');
# SELECT * FROM mytable;
# \q
# docker container stop postgres
# docker container rm postgres
# docker container ps
# docker container ls -a
# docker container logs postgres
# #
# to show tables in a database on a PostgreSQL server
# connect to the database
# \dt 
# to show the columns of a table
# postgres=# CREATE TABLE mytable
# postgres-# (id serial PRIMARY KEY,
# postgres(# name VARCHAR(50));
# 
# permission denied for schema public
#
# myuser=# GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO myuser;
# GRANT
# which will give the user myuser all privileges on all tables in the public schema
