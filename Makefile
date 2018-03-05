build:
	npm install
	cd client && npm install 
	docker build -t gcp-workshop --build-arg GIT_COMMIT=$(git log -1 --format=%h) .

run:
	docker rm -f gcp-workshop-app || true
	docker run -p 5000:5000 -p 3000:3000 -e GITSHA=$(git log -1 --format=%h) --name gcp-workshop-app gcp-workshop
