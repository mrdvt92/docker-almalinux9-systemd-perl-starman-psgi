FROM almalinux/9-init

RUN dnf -y install epel-release && dnf clean all
RUN dnf -y update               && dnf clean all
RUN dnf config-manager --set-enabled crb
RUN yum -y install https://linux.davisnetworks.com/el9/updates/mrdvt92-release-8-3.el9.mrdvt92.noarch.rpm && yum clean all
RUN yum -y install perl-Starman perl-DateTime 'perl(Plack::Middleware::Expires)' 'perl(Plack::Middleware::Session::Cookie)' 'perl(Plack::Middleware::Favicon_Simple)' 'perl(Plack::Middleware::Method_Allow)' && yum clean all

#Install psgi app
COPY app.psgi /app/

#Install systemd unit file for Starman running app.psgi on port 80
COPY ./starman.service /usr/lib/systemd/system/

#Enable Starman on boot
RUN systemctl enable starman.service

EXPOSE 80
VOLUME [ "/tmp", "/run", "/run/lock" ]
CMD ["/usr/sbin/init"]
#CMD ["/usr/bin/starman", "--workers", "3", "--port", "80", "/app/app.psgi"]
