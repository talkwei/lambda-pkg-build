FROM lambci/lambda:build-python3.6

COPY docker-lambda-with-virtual.sh /
COPY requirements.txt /

# Set the default directory where CMD will execute
WORKDIR /
CMD ["/bin/bash"]

ENV LAMBDA_BUILD /lambda_build
RUN ./docker-lambda-with-virtual.sh
