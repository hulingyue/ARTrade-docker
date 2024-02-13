IMAGE_NAME="artrade-docker"

# stop & remove image
docker stop $(docker ps -aq --filter "ancestor=$IMAGE_NAME")
docker rmi -f $(docker images -q --filter "reference=$IMAGE_NAME")

# build image
docker build -t $IMAGE_NAME .

# run image
docker run -v ./files:/FILES $IMAGE_NAME