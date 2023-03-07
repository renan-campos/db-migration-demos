CWD=$( dirname -- "$( readlink -f -- "$0"; )"; )

source $CWD/db_access.sh

die() {
  echo $1
  exit 1
}

(
publisher_psql < $CWD/data/publisher.dump &> /dev/null && echo "Publisher data successfully populated"
) || die "Failed to populate publisher data"
