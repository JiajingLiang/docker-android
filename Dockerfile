# Android development environment with ubuntu 16.04

# Set the base image to Ubuntu 16.04 LTS
FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER Jiajing LIANG <Liangjj19901005@gmail.com>

# run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

# Setup environment variables for jdk, android sdk
ENV JDK_VERSION 8
ENV ANDROID_SDK_VERSION "24.4.1"
ENV ANDROID_BUILD_TOOLS_VERSION "24.0.1"
ENV ANDROID_TARGET_SDK_VERSION "24"

# Add i386 architecture packages for running 32 bit Android tools
RUN dpkg --add-architecture i386

# Update the repository sources list
RUN apt-get update

# Install add-apt-repository, i386 libs (for 32 bit)
RUN apt-get install -y software-properties-common libc6:i386 libstdc++6:i386 libgcc1:i386 libncurses5:i386 libz1:i386 libx11-6:i386 libxrender1:i386

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

# Download android sdk to /opt
RUN wget https://dl.google.com/android/android-sdk_r${ANDROID_SDK_VERSION}-linux.tgz

# decompress android sdk file and remove the .tgz file
RUN tar -xvzf android-sdk_r${ANDROID_SDK_VERSION}-linux.tgz --directory /opt/
RUN rm android-sdk_r${ANDROID_SDK_VERSION}-linux.tgz

# set ANDROID_HOME environment variables
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/platform-tools

# Install Android SDK components
RUN echo y | android update sdk --no-ui --all --filter tools,platform-tools,build-tools-${ANDROID_BUILD_TOOLS_VERSION},android-${ANDROID_TARGET_SDK_VERSION},source-${ANDROID_TARGET_SDK_VERSION},sys-img-x86-addon-google_apis-google-${ANDROID_TARGET_SDK_VERSION},sys-img-armeabi-v7a-addon-google_apis-google-${ANDROID_TARGET_SDK_VERSION},addon-google_apis-google-${ANDROID_TARGET_SDK_VERSION},extra-android-support,extra-android-m2repository,extra-google-m2repository 
