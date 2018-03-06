build:
	npm install
	cd client && npm install 
	docker build -t gcp-workshop --build-arg GIT_COMMIT=$(shell git log -1 --format=%h) .

run:
	docker rm -f gcp-workshop-app || true
	docker run -p 3000:3000 -e GITSHA=$(shell git log -1 --format=%h) --name gcp-workshop-app gcp-workshop

stop:
	docker rm -f gcp-workshop-app || true
