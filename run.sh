#!/bin/sh
adb kill-server
sudo docker run -t -i --privileged --expose 5037 -v /dev/bus/usb:/dev/bus/usb -v $PWD:/home/docker oouyang/docker-adb /bin/bash
