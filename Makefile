build:
	npm install
	cd client && npm install 
	docker build -t gcp-workshop --build-arg GIT_COMMIT=$(shell git log -1 --format=%h) .

run:
	docker rm -f gcp-workshop-app || true
	docker run -p 3000:3000 -e GITSHA=$(shell git log -1 --format=%h) --name gcp-workshop-app gcp-workshop

stop:
	docker rm -f gcp-workshop-app || true
<<<<<<< HEAD
<<<<<<< HEAD
=======

k8s-create:
	kubectl create -f k8s/gcp-workshop.yml

k8s-update:
	kubectl set image deployments/hello-app hello-app=gcr.io/google-samples/hello-app:2.0
>>>>>>> update README
=======
>>>>>>> update README
