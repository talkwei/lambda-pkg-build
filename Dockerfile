FROM lambci/lambda:build-python3.6
MAINTAINER "Vivant" <vivant@lendingworks.co.com>

RUN mkdir /app
ADD docker-lambda-with-virtual.sh /app/.
ADD numpy_pickle_utils.py /app/.
ADD model.pkl /app/.
#RUN chmod +x /app/docker-lambda-with-virtual.sh
#RUN /app/docker-lambda-with-virtual.sh

# Set the default directory where CMD will execute
WORKDIR /
CMD ["/bin/bash"] 

