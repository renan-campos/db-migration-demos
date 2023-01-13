docker run \
  -d \
  -e POSTGRES_DB=publisher_db  \
  -e POSTGRES_USER=publisher_user \
  -e POSTGRES_PASSWORD=foobar \
  --name publisher_psql \
  -v "$PWD/conf/publisher.conf":/etc/postgresql/postgresql.conf:z \
  postgres -c 'config_file=/etc/postgresql/postgresql.conf'
docker run \
  --name subscriber_psql \
  -e POSTGRES_DB=subscriber_db \
  -e POSTGRES_USER=subscriber_user \
  -e POSTGRES_PASSWORD=foobar \
  -d postgres

# To log in:
# export PGPASSWORD=foobar; 
# psql --host $(docker_name2ip publisher_psql)  --user publisher_user  publisher_db
# psql --host $(docker_name2ip subscriber_psql) --user subscriber_user subscriber_db
#
# To check on the detabase:
# docker exec -it publisher_psql bash
