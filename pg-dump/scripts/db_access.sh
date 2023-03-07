#
# Helpers to access the publisher and subscriber databases
#

# The line was based on this SO answer: 
# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
CWD=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source $CWD/container_helpers.sh

subscriber_psql() {
  export PGPASSWORD=foobar; psql --host $(container_name2ip subscriber_psql) --user subscriber_user subscriber_db
}

publisher_psql() {
  export PGPASSWORD=foobar; psql --host $(container_name2ip publisher_psql) --user publisher_user publisher_db
}
