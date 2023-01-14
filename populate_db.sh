# This was attained using the pg_dump command.
export PGPASSWORD=foobar; psql --set ON_ERROR_STOP=on --host $(docker_name2ip publisher_psql) --user publisher_user publisher_db < data/publisher.dump
# Logical replication requires that the tables are present on the subscription database.
# These tables were acquired using "pg_dump --schema-only"
# Note: The owner of the tables was manually changed from "publisher_user" to "subscriber_user"
export PGPASSWORD=foobar; psql --set ON_ERROR_STOP=on --host $(docker_name2ip subscriber_psql) --user subscriber_user subscriber_db < data/subscriber.dump

# The following is needed
# publisher_db=# CREATE PUBLICATION pet_publication FOR TABLE pets;
# publisher_db=# CREATE ROLE subscriber_user WITH LOGIN REPLICATION PASSWORD 'foobar';
# publisher_db=# GRANT SELECT ON TABLE pets TO subscriber_user;

# subscriber_db=# CREATE SUBSCRIPTION pet_subscription
# CONNECTION 'host=172.17.0.2 user=subscriber_user password=foobar dbname=publisher_db application_name=pet_subscription'
# PUBLICATION pet_publication;

# TO MONITOR ON PUBLISHER:
# publisher_db=# SELECT * FROM pg_stat_replication;

# TO MONITOR ON SUBSCRIBER:
# subscriber_db=# SELECT * FROM pg_stat_subscription;
#  subid |     subname      | pid | relid | received_lsn |      last_msg_send_time       |     last_msg_receipt_time     | latest_end_lsn |        latest_end_time        
# -------+------------------+-----+-------+--------------+-------------------------------+-------------------------------+----------------+-------------------------------
#  16401 | pet_subscription | 282 |       | 0/1990DA0    | 2023-01-13 22:46:18.490325+00 | 2023-01-13 22:46:18.490542+00 | 0/1990DA0      | 2023-01-13 22:46:18.490325+00
