rm *.zip
docker build -t bluecargo/lambda .
# docker run -v $pwd/outputs -it lambda /bin/bash /outputs/docker-lambda-with-virtual.sh
docker run  -v `pwd`:`pwd` -w `pwd` -i -t bluecargo/lambda cp /lambda_build/lambda.zip lambda.zip
docker push bluecargo/lambda
