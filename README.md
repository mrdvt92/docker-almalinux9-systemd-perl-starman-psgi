#Name

docker-centos7-systemd-perl-starman-psgi - Dockerfile for Starman PSGI server running on CentOS7 under Systemd

#Docker Image

This Docker inage is built from the Official CentOS 7 image from https://hub.docker.com/_/centos.

#Systemd

The docker image uses the Systemd configuration from https://hub.docker.com/_/centos#Systemd+integration

#Starman

[Starman](https://metacpan.org/release/Starman) is a high-performance preforking [PSGI/Plack](https://metacpan.org/release/Plack) web server.  We install it from RPMs at [OpenFusion](http://repo.openfusion.net/centos7-x86_64/)

#Systemd Unit File

The Starman Systemd Unit File is installed by the Dockerfile as /usr/lib/systemd/system/starman.service and then enabled with systemctl.

#PSGI App

The PSGI App is in the GIT repository saved as ```.`/app.psgi.```  Any runtime dependancies to run the PSGI app inside the containier must be spefidied in the Dockerfile.  We install four depandicies for our exmaple PSGI program.

1. perl-DateTime
2. perl-Plack-Middleware-Expires from DavisNetworks.com
3. perl-Plack-Middleware-Session from DavisNetworks.com
4. perl-Cookie-Baker for perl-Plack-Middleware-Session from DavisNetworks.com
