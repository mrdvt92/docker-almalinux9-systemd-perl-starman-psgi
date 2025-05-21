CONTAINER_NAME=starman
IMAGE_NAME=local/starman

all:

build:	Dockerfile app.psgi starman.service
	docker build --rm --tag=$(IMAGE_NAME) .

run:
	docker run -ti --privileged --name $(CONTAINER_NAME) --cap-add SYS_ADMIN --security-opt seccomp=unconfined --cgroup-parent=docker.slice --cgroupns=private --tmpfs /tmp --tmpfs /run --tmpfs /run/lock --publish 5000:80 $(IMAGE_NAME)

bash:
	docker exec -it $(CONTAINER_NAME) /bin/bash

rm:	
	docker stop $(CONTAINER_NAME)
	docker rm $(CONTAINER_NAME)

journal:
	docker exec -it $(CONTAINER_NAME) journalctl -f -u starman.service
