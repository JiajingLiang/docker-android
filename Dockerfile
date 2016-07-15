# Android development environment with ubuntu 16.04

# Set the base image to Ubuntu 16.04 LTS
FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER Jiajing LIANG <Liangjj19901005@gmail.com>

# run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

# Setup environment variables for jdk
ENV JDK_VERSION 8

# Add i386 architecture packages for running 32 bit Android tools
RUN dpkg --add-architecture i386

# Update the repository sources list
RUN apt-get update

# Install add-apt-repository and i386 libs (for 32 bit)
RUN apt-get install -y software-properties-common libc6-i386 lib32stdc++6 lib32z1 lib32ncurses5 lib32gcc1

# Add oracle-jdk to repositories
RUN add-apt-repository ppa:webupd8team/java

# Update the repository sources list
RUN apt-get update

# Accept Oracle license
RUN echo "debconf shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN echo "debconf shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections

# Install Oracle JDK 8
RUN apt-get install -y oracle-java${JDK_VERSION}-installer

# Clear apt-get list and temp file to release space
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN apt-get autoremove -y
RUN apt-get clean

# Set JAVA_HOME environment variables
ENV JAVA_HOME /usr/lib/jvm/java-${JDK_VERSION}-oracle

