# This dockerfile uses the ubuntu image
# VERSION 1 - EDITION 1
# Author: kakotor
# Command format: Instruction [arguments / command] ..

# Base image to use, this must be set as the first line
FROM ubuntu:latest
RUN  apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*

RUN wget -O frp.tar.gz https://github.com/fatedier/frp/releases/download/v0.8.1/frp_0.8.1_linux_386.tar.gz
RUN tar -xf frp.tar.gz -C /opt
RUN cd /opt
RUN mv frp_0.8.1_linux_386 frp

COPY frps.ini /opt/frp/frps.ini

EXPOSE 4443 4444 80

ENTRYPOINT ["nohup","/opt/frp/frps","-c","/opt/frp/frps.ini",">/dev/null","2>&1","&"]
