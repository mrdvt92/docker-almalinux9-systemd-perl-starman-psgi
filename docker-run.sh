#!/usr/bin/sh
sudo docker run -d --name starman --tmpfs /run -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 5001:80 local/centos7-systemd-perl-starman-psgi
