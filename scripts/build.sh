docker build -t lambda .
docker run -v $(pwd):/outputs -it lambda \
      /bin/bash /outputs/docker-lambda-with-virtual.sh