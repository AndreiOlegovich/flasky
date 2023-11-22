# getting base image ubuntu
FROM ubuntu:22.04

LABEL maintainer="www.urn.su"

CMD ["echo", "HH: image is creating"]

ENV TEST_DIR=/opt 
ENV PYTHON_DIR=/user/local/bin/python
ENV ROBOT_RESOURCES=/opt/tests/robot/src/resources
ENV ROBOT_LIBRARIES=/opt/robot/src/libraries
    # ROBOT_MODIFIERS=/opt/robot/src/modifiers \
    # ROBOT_INPUT=/opt/robot/input \
    # ROBOT_OUTPUT=/opt/robot/output

# ENV PYTHONPATH=$TEST_DIR:$PYTHON_DIR$ROBOT_LIBRARIES:$ROBOT_RESOURCES:$ROBOT_MODIFIERS
ENV PYTHONPATH=$TEST_DIR:$PYTHON_DIR:$ROBOT_RESOURCES
ENV TZ=Europe/Helsinki
ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir -p $TEST_DIR

WORKDIR $TEST_DIR

# old way - ADD
# ADD src $TEST_DIR
# new way - create VOLUME
VOLUME $TEST_DIR


# apt-get is recommended for Docker files

# install linux utils
RUN apt-get -y update \
  && apt-get install -y dialog \
  && apt-get install -y apt-utils \
  && apt-get install -y tree vim ssh \
  && apt-get install -y curl gcc g++ make nmap net-tools netcat \
  && apt-get -y update \
  && apt-get -y upgrade


# install python
RUN apt-get install -y python3 python3-pip \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && python -m pip install --upgrade pip

# install dependencies
COPY requirements.ubuntu.pytest.txt .
RUN python -m pip install -r requirements.ubuntu.pytest.txt

# Install node16
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs && \
  # Feature-parity with node.js base images.
  apt-get install -y --no-install-recommends git openssh-client && \
  npm install -g yarn && \
  npm install -g npm@9.1.2 &&\
  # clean apt cache
  rm -rf /var/lib/apt/lists/* && \
  # Create the pwuser
  adduser pwuser


# install dependencies
COPY requirements.ubuntu.robot.txt .
RUN python -m pip install -r requirements.ubuntu.robot.txt
RUN rfbrowser init
RUN npx -y playwright install-deps
