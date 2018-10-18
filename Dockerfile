FROM lambci/lambda:build-python3.6

RUN mkdir /app
COPY docker-lambda-with-virtual.sh /app/.
COPY requirements.txt /app

# Set the default directory where CMD will execute
WORKDIR /app
CMD ["/bin/bash"]

RUN ./docker-lambda-with-virtual.sh
