docker build -t bluecargo/lambda .
# docker run -v $pwd/outputs -it lambda /bin/bash /outputs/docker-lambda-with-virtual.sh
# docker run  -v `pwd`:`pwd` -w `pwd` -i -t bluecargo/lambda cp lambda.zip lambda2.zip
docker push bluecargo/lambda
