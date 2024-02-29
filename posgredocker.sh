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
docker container exec -it postgres psql -U postgres -d postgres -c "SELECT versoin();"
docker container exec -it postgres psql -U postgres -C "CREATE DATABASE mydb;"
docker container exec -it postgres psql -U posgres -C "CREATE USER myuser WITH PASSWORD 'mypass';"
docker container exec -it postgres psql -U postgres C "GRANT ALL PRIVILEGES ON DATABASE mydb TO myuser;"
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
# show databases;
# show posgres databases;
# show users;
# show tables;
# select * from users;
#\x 
#
# Select datname from pg_database\g
# Select usename from pg_user;
# Select * from pg_user;
# Select * from pg_tables;
# Select * from pg_roles;
# Select * from pg_settings;
# Select * from pg_stat_activity;
# Select * from pg_stat_user_tables;
# Select * from pg_stat_user_indexes;
# Select * from pg_stat_replication;
# Select * from pg_stat_ssl;
# Select * from pg_stat_database;
# Select * from pg_stat_bgwriter;
# Select * from pg_stat_all_tables;
# Select * from pg_stat_all_indexes;
# Select * from pg_user;
# update pg_user set uscreatedb = true where username = 'myuser';
# this will allow this user to create databases
# update pg_user set userepl = true where username = 'myuser';
# this will allow this user to replicate databases
# update pg_user set usesuper = true where username = 'myuser';
#
# GRANT ALL PRIVILEGES ON SCHEMA public TO myuser;
# GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO myuser;
# GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO myuser;
# GRANT ALL PRIVILEGES ON DATABASE mydb TO myuser;
# GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO myuser;
# GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO myuser;
# permissions denied for schema public
# GRANT USAGE ON SCHEMA public TO myuser
# GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO myuser;
# GRANT SELECT, USAGE ON ALL SEQUENCES IN SCHEMA public TO myuser;
# GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO myuser;
# GRANT SELECT, USAGE ON ALL SEQUENCES IN SCHEMA public TO myuser;
# howto look for permissions
# SELECT * FROM information_schema.table_privileges WHERE grant is not null;
# SELECT * FROM information_schema.role_table_grants WHERE user_name = 'myuser';
#
# create talble if not exists flims (
# id uuid primary key default uuid_generate_v4() not null constraint flims_pkey,
# title text not null,
# year smallint not null,
# director text not null,
# created_at timestamp with time zone default CURRENT_TIMESTAMP not null,
# updated_at timestamp with time zone
# );
#
# create table if not exists actors (
# id uuid primary key default uuid_generate_v4() not null constraint actors_pkey,
# first_name text not null,
# last_name text not null,
# created_at timestamp with time zone default now() not null,
# updated_at timestamp with time zone
# );
#
#  to rename a table flims to films 
#  alter table flims rename to films;
#  to rename a column title to name
#  alter table films rename column title to name;
# 
# insert into films (title, year, director) values ('The Godfather', 1972, 'Francis Ford Coppol# a');
# insert into films (title, year, director, poster) values 
# ('The Godfather', 1972, 'Francis Ford Coppola', 
# 'https://www.imdb.com/title/tt0068646/mediaviewer/rm4285931520');
# insert into films (title, year, director, poster) values
# ('Terminator 2: Judgment Day', 1991, 'James Cameron',
# 'https://www.imdb.com/title/tt0103064/mediaviewer/rm4285931520');
# insert into films (title, year, director, poster) values
# ('The Matrix', 1999, 'Lana Wachowski, Lilly Wachowski',
# 'https://www.imdb.com/title/tt0133093/mediaviewer/rm4285931520');
# select * from films where created_at > '2024-02-28 13:08:00';
# select * from films where created_at > '2024-02-28 13:08:00' and year > 1990;
#
# update films set updated_at = now() and director = 'Francis Ford Coppola' 
# where title = 'The Godfather';
# 
#
# docker container volume ls 
# to find out the directory of the volume
# docker container inspect postgres
# docker container inspect postgres | grep -i volume
# docker container inspect postgres | grep -i volume -A 2
#
