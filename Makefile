.PHONY: all build bash start exec
NAME=citadel
AUTHOR=belooussov
VERSION=latest
FULLDOCKERNAME=$(AUTHOR)/$(NAME):$(VERSION)

all: build

build:
	docker build --no-cache=false -t $(FULLDOCKERNAME) .

start: clean
	docker run -d --name citadel -p 443:443 $(AUTHOR)/$(NAME):latest

exec:
	docker exec -ti citadel bash

clean:
	-docker rm -f citadel
