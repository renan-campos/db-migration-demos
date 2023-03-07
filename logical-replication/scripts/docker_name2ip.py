#! /usr/bin/python
#
# A script that prints the ip address of the docker container matching the provided name
#

import docker

client = docker.from_env()

def container_from_name(name):
    for c in client.containers.list():
        if c.name == name:
            return c
    return None

def ip_from_container(container):
    if container == None:
        return None
    return container.attrs['NetworkSettings']['IPAddress']

if __name__ == '__main__':
    import sys
    if len(sys.argv) < 2:
        sys.stderr.write("Expected container name as command line argument\n")
        sys.exit(1)
    name = sys.argv[1]
    ip = ip_from_container(container_from_name(name))
    if ip == None:
        sys.stderr.write(f"Container '{name}' not found\n")
        sys.exit(1)
    print(ip)
