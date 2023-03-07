This repository holds a set of scripts used to test out postgres's logical replication mechanism.

1. Create the database resources
```
$ bash scripts/create_dbs.sh 
Publisher database successfully created
Subscriber database successfully created
```

2. Populate the databases with data
```
$ bash scripts/populate_dbs.sh 
Publisher data successfully uploaded
Subscriber data successfully uploaded
```

3. Create the publication on publisher db
```
$ . ./scripts/db_access.sh 
$ publisher_psql 
psql (13.4, server 15.1 (Debian 15.1-1.pgdg110+1))
WARNING: psql major version 13, server major version 15.
         Some psql features might not work.
Type "help" for help.

publisher_db=# CREATE PUBLICATION pet_publication FOR TABLE pets;
CREATE PUBLICATION
publisher_db=# CREATE ROLE subscriber_user WITH LOGIN REPLICATION PASSWORD 'foobar';
CREATE ROLE
publisher_db=# GRANT SELECT ON TABLE pets TO subscriber_user;
GRANT
publisher_db=# 
\q
```

4. Create the subscription on the subscriber db
```
$ . ./scripts/container_helpers.sh 
$ container_name2ip publisher_psql
172.17.0.2
$ subscriber_psql 
psql (13.4, server 15.1 (Debian 15.1-1.pgdg110+1))
WARNING: psql major version 13, server major version 15.
         Some psql features might not work.
Type "help" for help.

subscriber_db=# CREATE SUBSCRIPTION pet_subscription
subscriber_db-# CONNECTION 'host=172.17.0.2 user=subscriber_user password=foobar dbname=publisher_db application_name=pet_subscription'
subscriber_db-# PUBLICATION pet_publication;
NOTICE:  created replication slot "pet_subscription" on publisher
CREATE SUBSCRIPTION
subscriber_db=# 
\q
```


5. Monitor the publisher:
```
$ publisher_psql 
psql (13.4, server 15.1 (Debian 15.1-1.pgdg110+1))
WARNING: psql major version 13, server major version 15.
         Some psql features might not work.
Type "help" for help.

publisher_db=# SELECT * FROM pg_stat_replication;
publisher_db=# 
\q
```

6. Monitor the subscriber:
```
$ subscriber_psql 
psql (13.4, server 15.1 (Debian 15.1-1.pgdg110+1))
WARNING: psql major version 13, server major version 15.
         Some psql features might not work.
Type "help" for help.
subscriber_db=# SELECT * FROM pg_stat_subscription
subscriber_db-# ;
 subid |     subname      | pid | relid | received_lsn |      last_msg_send_time       |     last_msg_receipt_time     | latest_end_lsn |        latest_end_time        
-------+------------------+-----+-------+--------------+-------------------------------+-------------------------------+----------------+-------------------------------
 16399 | pet_subscription |  84 |       | 0/198E410    | 2023-03-07 00:36:29.779392+00 | 2023-03-07 00:36:29.779736+00 | 0/198E410      | 2023-03-07 00:36:29.779392+00
(1 row)

subscriber_db=# 
\q
```
