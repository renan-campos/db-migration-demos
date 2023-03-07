CWD=$( dirname -- "$( readlink -f -- "$0"; )"; )

source $CWD/db_access.sh

export PGPASSWORD=foobar;

(
publisher_psql < $CWD/data/publisher.dump &> /dev/null && echo "Publisher data successfully uploaded"
) || die "Failed to upload publisher data"
  

# Logical replication requires that the tables are present on the subscription database.
# These tables were acquired using "pg_dump --schema-only"
# Note: The owner of the tables was manually changed from "publisher_user" to "subscriber_user"
(
subscriber_psql < $CWD/data/subscriber.dump &> /dev/null && echo "Subscriber data successfully uploaded"
) \
  || die "Failed to upload subscriber data"
#export PGPASSWORD=foobar; psql --set ON_ERROR_STOP=on --host $(container_name2ip publisher_psql) --user publisher_user publisher_db < data/publisher.dump

#export PGPASSWORD=foobar; psql --set ON_ERROR_STOP=on --host $(container_name2ip subscriber_psql) --user subscriber_user subscriber_db < data/subscriber.dump
