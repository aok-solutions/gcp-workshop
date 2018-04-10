git_commit = $(shell git log -1 --format=%h)
project_id = $(shell gcloud config get-value project -q)

build:
	npm install
	cd client && npm install
	docker build -t gcp-workshop --build-arg GIT_COMMIT=$(git_commit) .

run:
	docker rm -f gcp-workshop-app || true
	docker run -d -p 3000:3000 -e GITSHA=$(git_commit) --name gcp-workshop-app gcp-workshop

stop:
	docker rm -f gcp-workshop-app || true

build-gcp:
	docker build -t gcr.io/$(project_id)/gcp-demo:$(git_commit) --build-arg GIT_COMMIT=$(git_commit) .
	gcloud docker -- push gcr.io/$(project_id)/gcp-demo:$(git_commit)

run-gcp:
	docker rm -f gcp-demo gcr.io/$(project_id)/gcp-demo:$(git_commit) || true
	docker run --rm -d -p 3000:3000 -e GITSHA=$(git_commit) --name gcp-demo gcr.io/$(project_id)/gcp-demo:$(git_commit)

stop-gcp:
	docker rm -f gcp-demo gcr.io/$(project_id)/gcp-demo:$(git_commit) || true
