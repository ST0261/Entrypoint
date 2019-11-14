echo "Checking if docker is installed"
if ! [ -x "$(command -v docker)" ]; then
    echo "Install and start docker"
    yum update -y
    yum install -y docker
    service docker start
    usermod -a -G docker ec2-user
    echo "Done..."
else
    echo 'Docker is installed'
fi

docker stop entrypoint-container
docker rm entrypoint-container

docker pull  nginx

docker container run \
    -d \
    --name entrypoint-container \
    -p 80:80 \
    -v $(pwd)/data/nginx.conf:/etc/nginx/nginx.conf nginx
    


