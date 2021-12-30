all:
	@echo "Syntax:"
	@echo "  make build   # builds the docker image from the Dockerfile as local/centos7-systemd-perl-starman-psgi"
	@echo "  make run     # runs the docker image local/centos7-systemd-perl-starman-psgi as starman on http://127.0.0.1:5000/"
	@echo "  make rm      # stops and removes the image starman"
	@echo "  make shell   # executes a bash shell on the running starman container"
	@echo "  make journal # executes journalctl inside the starman container"

build:	Dockerfile app.psgi starman.service
	docker build --rm --tag=local/centos7-systemd-perl-starman-psgi .

run:
	docker run --detach --name starman --tmpfs /run --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro --publish 5000:80 local/centos7-systemd-perl-starman-psgi

bash:
	docker exec -it starman /bin/bash

rm:	
	docker stop starman
	docker rm starman

shell:
	docker exec -it starman /bin/bash

journal:
	docker exec -it starman journalctl -f -u starman.service
