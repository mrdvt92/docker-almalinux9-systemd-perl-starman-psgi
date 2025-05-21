# Name

docker-almalinux9-systemd-perl-starman-psgi - Dockerfile for Starman PSGI server running on Alma Linux 9 under Systemd

# Docker Image

This Docker image is built from [almalinux/9-init](https://hub.docker.com/r/almalinux/9-init).

# Systemd

The docker image uses the Systemd configuration from https://serverfault.com/questions/1053187/systemd-fails-to-run-in-a-docker-container-when-using-cgroupv2-cgroupns-priva

# Starman

[Starman](https://metacpan.org/release/Starman) is a high-performance preforking [PSGI/Plack](https://metacpan.org/release/Plack) web server.  We install it with ```yum``` from RPMs at [DavisNetworks](https://linux.davisnetworks.com/el9/)

# Systemd Unit File

The Starman Systemd Unit File is installed by the Dockerfile as ```/usr/lib/systemd/system/starman.service``` and then enabled with ```systemctl```.  Starman is configured to run 3 workers and to listen on port 80 (this port must match the Dockerfile exposed port).

# PSGI App

The PSGI App ```app.psgi```  is saved inside the Docker image as ```/app/app.psgi```. This path is hard coded in the service file.

# PSGI App Dependencies

Dependencies to run the PSGI app inside the container must be installed in the Dockerfile.  We install the dependencies for our example PSGI program one from the Alma Linux repositories and from the [DavisNetworks.com](http://linux.davisnetworks.com/el7/updates/) repository.

* [DateTime](https://metacpan.org/release/DateTime)
* [Plack::Middleware::Expires](https://metacpan.org/release/Plack-Middleware-Expires)
* [Plack::Middleware::Session::Cookie](https://metacpan.org/release/Plack-Middleware-Session)
* [Plack::Middleware::Favicon_Simple](https://metacpan.org/dist/Plack-Middleware-Favicon_Simple)
* [Plack::Middleware::Method_Allow](https://metacpan.org/dist/Plack-Middleware-Method_Allow)

# Docker Build Command

```
$ make build
```

# Docker Run Command

```
$ make run
```

# See Also

* [CentOS7-Systemd-Mojolicious](https://github.com/bislink/CentOS7-Systemd-Mojolicious)
