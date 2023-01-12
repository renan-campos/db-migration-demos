export PGPASSWORD=foobar; psql --set ON_ERROR_STOP=on --host $(docker_name2ip publisher_psql) --user publisher_user publisher_db < pets.dump
