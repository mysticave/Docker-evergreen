# Base python 2.7 build, inspired by
# https://github.com/biswasdebsubhra/Docker-evergreen/blob/master/Dockerfile
FROM ubuntu:16.04
MAINTAINER Debsubhra Biswas, dbiswas@smartshifttech.com

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
    build-essential \
    ca-certificates \
    gcc \
    git \
    libpq-dev \
    make \
    python-pip \
    python2.7 \
    python2.7-dev \
    ssh \
    && apt-get autoremove \
    && apt-get clean

# RUN git clone http://dbiswas@stash.corp.web:7990/scm/do/evergreen.git
# Copying the evergreen dir from the Jenkins machine to the container
ADD path/to/evergreen_jenkins_machine .

WORKDIR "/evergreen"
# install "virtualenv", since the vast majority of users of this image will want it
RUN pip install --no-cache-dir virtualenv
RUN virtualenv venv
RUN . ./venv/bin/activate
RUN pip install -r requirements.txt
RUN pip install --editable .
RUN make test
RUN make cover

CMD []
ENTRYPOINT ["/usr/bin/python2.7"]
