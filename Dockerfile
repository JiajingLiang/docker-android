# Android development environment with ubuntu 16.04

# Set the base image to Ubuntu 16.04 LTS
FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER Jiajing LIANG <Liangjj19901005@gmail.com>

# run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

# Setup environment variables for jdk
ENV JDK_VERSION 8

# Add oracle-jdk8 to repositories
RUN add-apt-repository ppa:webupd8team/java

# Update the repository sources list
RUN apt-get update

# Install Oracle JDK 8
RUN apt-get install oracle-java${JDK_VERSION}-installer

RUN echo $JAVA_HOME

