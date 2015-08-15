FROM ubunut
MAINTAINER Owen Ouyang <owen.ouyang@live.com>

# Install prerequisites
RUN apt-get update && \
    apt-get install -y wget curl \
                       git python-setuptools python-virtualenv python-pip\
                       android-tools-adb android-tools-fastboot python-dev \
                       libusb-1.0-0 libusb-1.0-0-dev \
                       usbutils unzip 

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# add usb device rules
ADD 51-android.rules /etc/udev/rules.d/51-android.rules

# add user
RUN groupadd -r docker -g 1000 && useradd -r -u 1000 -s /bin/bash -m -g docker docker
RUN echo "docker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER docker
WORKDIR /home/docker

# volume
VOLUME ["/home/docker", "/dev/bus/usb"]

# adb port
EXPOSE 5037
