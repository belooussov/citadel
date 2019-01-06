.PHONY: all build bash start
NAME=citadel
AUTHOR=belooussov
VERSION=latest
FULLDOCKERNAME=$(AUTHOR)/$(NAME):$(VERSION)

all: build

build:
	docker build --no-cache=false -t $(FULLDOCKERNAME) .

bash:
	docker run -it -p 443:443 --entrypoint /bin/bash $(AUTHOR)/$(NAME):latest

start:
	docker run -d -p 443:443 $(AUTHOR)/$(NAME):latest
