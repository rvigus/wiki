```
# remove all containers
docker rm -vf $(docker ps -aq)

# remove all local images
docker rmi -f $(docker images -aq)

```


