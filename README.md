# Name

docker-centos7-systemd-perl-starman-psgi - Dockerfile for Starman PSGI server running on CentOS7 under Systemd

# Docker Image

This Docker image is built from the [Official CentOS 7 Docker Image](https://hub.docker.com/_/centos).

# Systemd

The docker image uses the Systemd configuration from https://hub.docker.com/_/centos#Systemd+integration

# Starman

[Starman](https://metacpan.org/release/Starman) is a high-performance preforking [PSGI/Plack](https://metacpan.org/release/Plack) web server.  We install it with ```yum``` from RPMs at [OpenFusion](http://repo.openfusion.net/centos7-x86_64/)

# Systemd Unit File

The Starman Systemd Unit File is installed by the Dockerfile as /usr/lib/systemd/system/starman.service and then enabled with systemctl.  Starman is configured to run 3 workers and to listen on port 80.

# PSGI App

The PSGI App ```app.psgi```  is saved in the image as ```/app/app.psgi```.

# PSGI App Dependencies

Dependencies to run the PSGI app inside the container must be install in the Dockerfile.  We install four dependencies for our example PSGI program one from CentOS 7 base repository and two from [DavisNetworks.com](http://linux.davisnetworks.com/el7/updates/) repository.

1. [DateTime](https://metacpan.org/release/DateTime)
2. [Plack::Middleware::Expires](https://metacpan.org/release/Plack-Middleware-Expires)
3. [Plack::Middleware::Session::Cookie](https://metacpan.org/release/Plack-Middleware-Session)

# Docker Build Command

  $ sudo docker build --rm --tag=local/centos7-systemd-perl-starman-psgi .

* --rm - Remove intermediate containers after a successful build.

# Docker Run Command

  $ sudo docker run --detach --name starman --tmpfs /run -v /sys/fs/cgroup:/sys/fs/cgroup:ro --publish 5000:80 local/centos7-systemd-perl-starman-psgi

* --detach - Detached mode: run the container in the background and print the new container ID. (run as -ti to see more information for debugging)
* --tmpfs - required setting for CentOS 7 with Systemd
* -v - required volumn setting for CentOS 7 with Systemd
* --publish - Publish a container's port, or range of ports, to the host - [host]:[container]
