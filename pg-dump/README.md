This repository holds a set of scripts used to test out postgres's pg_dump method of migrating data

1. Create the database resources
```
  $ bash scripts/create_dbs.sh 
  Publisher database successfully created
  Subscriber database successfully created
```

2. Populate the databases with data
```
  $ bash scripts/populate_dbs.sh 
  Publisher data successfully populated
```

3. pg_dump to get the needed data from tables on the publisher database
```
  $ bash scripts/dump_data.sh 
  Publisher data dumped successfully.
```

4. Upload dumped data to the subscriber database
```
  $ bash scripts/upload_data.sh 
  Publisher data successfully uploaded to subscriber
```
