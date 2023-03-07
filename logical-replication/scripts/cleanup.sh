#
# Removes the resources created for this test.
#
docker rm -f subscriber_psql && echo "Subscriber database instance deleted"
docker rm -f publisher_psql && echo "Publisher database instance deleted"
