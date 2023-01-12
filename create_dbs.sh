docker run --name publisher_psql  -e POSTGRES_DB=publisher_db  -e POSTGRES_USER=publisher_user  -e POSTGRES_PASSWORD=foobar -d postgres
docker run --name subscriber_psql -e POSTGRES_DB=subscriber_db -e POSTGRES_USER=subscriber_user -e POSTGRES_PASSWORD=foobar -d postgres

# To log in:
# psql --host localhost --user service --password service
# psql --host localhost --port 5433 --user publisher_user --password publisher_db
# psql --host localhost --port 5434 --user subscriber_user --password subscriber_db

# docker exec -it publisher_psql bash


#publisher_db=# CREATE TABLE Pet (
#id INTEGER PRIMARY KEY,
#name TEXT,
#category TEXT
#);
#CREATE TABLE

