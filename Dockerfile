FROM centos:7

ENV container docker

RUN yum -y update

RUN echo "centos7-systemd: From: https://hub.docker.com/_/centos#Systemd+integration";\
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done);\
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*;\
rm -f /lib/systemd/system/sockets.target.wants/*udev*;\
rm -f /lib/systemd/system/sockets.target.wants/*initctl*;\
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*

RUN echo "OpenFusion shows warnings with these three RPM packages so install from CentOS base before we load OpenFusion repo";\
yum -y install perl-PathTools perl-Scalar-List-Utils perl-Storable

RUN echo "Install Starman and Dependancies from OpenFusion RPM repo";\
yum -y install http://repo.openfusion.net/centos7-x86_64/openfusion-release-0.8-1.of.el7.noarch.rpm;\
yum -y install perl-Starman

RUN echo "Install PSGI Application Dependancies";\
yum -y install perl-DateTime;\
yum -y install http://linux.davisnetworks.com/el7/updates/perl-Plack-Middleware-Expires-0.06-1.el7.mrdvt92.noarch.rpm http://linux.davisnetworks.com/el7/updates/perl-Cookie-Baker-0.11-1.el7.mrdvt92.noarch.rpm http://linux.davisnetworks.com/el7/updates/perl-Plack-Middleware-Session-0.33-1.el7.mrdvt92.noarch.rpm

#Install PSGI Application into /app/ folder
COPY ./app.psgi /app/

#Install Systemd unit file that keeps Starman running in case of die, etc.
COPY ./starman.service /usr/lib/systemd/system/

#Enable Starman on boot
RUN systemctl enable starman.service

#From: https://hub.docker.com/_/centos but I do not know what this statement does
VOLUME [ "/sys/fs/cgroup" ]

#Expose Starman web server on port 80
EXPOSE 80

#Command to start Systemd
CMD ["/usr/sbin/init"]
