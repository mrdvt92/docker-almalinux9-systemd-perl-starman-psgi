#!/usr/bin/sh
sudo docker run --detach --name starman --tmpfs /run -v /sys/fs/cgroup:/sys/fs/cgroup:ro --publish 5000:80 local/centos7-systemd-perl-starman-psgi
