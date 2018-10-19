FROM lambci/lambda:build-python3.6
WORKDIR /
CMD ["/bin/bash"]

COPY requirements.txt / \
    install_and_strip.sh / \
    export_zip.sh /

ENV LAMBDA_BUILD /lambda_build

RUN bash install_and_strip.sh

RUN bash export_zip.sh
