FROM openjdk:8-jre-slim

USER root

RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    python3-dev \
    python3-pip \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    sudo \
    gettext-base \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --upgrade setuptools pip wheel
RUN pip3 install lxml psutil bzt

ENTRYPOINT ["bash"]