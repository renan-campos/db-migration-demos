#
# This script creates two database containers.
# publisher will contain the data to be exported.
# subscriber will be the database which the data should be exported to.
#
CWD=$( dirname -- "$( readlink -f -- "$0"; )"; )

die() {
  echo $1
  exit 1
}

(
docker run \
  -d \
  -e POSTGRES_DB=publisher_db  \
  -e POSTGRES_USER=publisher_user \
  -e POSTGRES_PASSWORD=foobar \
  --name publisher_psql \
  -v "$CWD/conf/publisher.conf":/etc/postgresql/postgresql.conf:z \
  postgres -c 'config_file=/etc/postgresql/postgresql.conf' &> /dev/null \
&& echo "Publisher database successfully created"
) || die "Failed to create publisher database"

(
docker run \
  --name subscriber_psql \
  -e POSTGRES_DB=subscriber_db \
  -e POSTGRES_USER=subscriber_user \
  -e POSTGRES_PASSWORD=foobar \
  -d postgres &> /dev/null \
&& echo "Subscriber database successfully created"
) || die "Failed to create subscriber database"
