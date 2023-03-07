# The line was based on this SO answer: 
# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
CWD=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source $CWD/container_helpers.sh

die() {
  echo $1
  exit 1
}

(
export PGPASSWORD="foobar"; pg_dump \
  --host=$(container_name2ip publisher_psql) \
  --username=publisher_user \
  --dbname=publisher_db \
  --table=pets > $CWD/dumps/pets.dump && echo "Publisher data dumped successfully."
) || die "Publisher data failed to dump"
