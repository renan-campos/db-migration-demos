# The line was based on this SO answer: 
# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
CWD=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source $CWD/db_access.sh

die() {
  echo $1
  exit 1
}

(
subscriber_psql < $CWD/dumps/pets.dump &> /dev/null \
&& echo "Publisher data successfully uploaded to subscriber"
) || die "Failed to upload publisher data"
