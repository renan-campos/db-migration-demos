Logical replication requires specific configuration settings.
For the publisher:
* wal_level
    On the publisher side, wal_level must be set to logical. The default is
    replica. This wal_level represents a performance/redundancy tradeoff. There are
    three possible values for wal_level: minimal, replica, and logical. As the
    levels get higher, the amount of logging to the write-ahead-log is increased.
    This results in slower performance. For this demo, and probably most other
    database applications, this difference in speed is likely unimpactful. 
* max_replication_slots
    "max_replication_slots must be set to at least the number of subscriptions
    expected to connect, plus some reserve for table synchronization." The default
    for this is 10. Since there will only be one subscription, the default should
    be sufficient.
* max_wal_senders
    "And max_wal_senders should be set to at least the same as
    max_replication_slots plus the number of physical replicas that are connected
    at the same time." This also defaults to 10. Since our application will not
    have physical replicas, no change is needed.

For the subscriber:
* max_replication_slots
    "Should be set to at least the number of subscriptions". Since this is 10 by
    default, there is no need to change it.
* max_logical_replication_workers
    "Must be set to at lease the number of supscriptions, plus some reserve for the
    table synchronization". This defaults to 4, sufficient for a single
    subscription.
* max_worker_processes
    "May need to be adjusted to accommodate for replication workers, at least
    (max_logical_replication_workers+1). This defaults to 8, sufficient for a
    single subscription.

** The quotes are taken from the Postgres documentation.

So really, the only configuration that needs to change is the default
wal_level. On a running system, this change requires a restart.

The steps for configuring the postgres container are outlined in the
documentation on dockerhub: 
```
$ # get the default config
$ docker run -i --rm postgres cat /usr/share/postgresql/postgresql.conf.sample > my-postgres.conf

$ # customize the config

$ # run postgres with custom config
$ docker run -d --name some-postgres -v "$PWD/my-postgres.conf":/etc/postgresql/postgresql.conf -e POSTGRES_PASSWORD=mysecretpassword postgres -c 'config_file=/etc/postgresql/postgresql.conf'
```

