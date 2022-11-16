TAG=2808

build:
	docker build -t minhdt/convert-document:$(TAG) .
	docker tag minhdt/convert-document:$(TAG) minhdt/convert-document:latest

push:
	docker push minhdt/convert-document:$(TAG)
	docker push minhdt/convert-document:latest

shell: build
	docker run -ti -v $(PWD):/convert -p 3000:3000 minhdt/convert-document bash

run: build
	docker run -p 3000:3000 --tmpfs /tmp --rm -ti minhdt/convert-document

test:
	rm out.pdf
	curl -o out.pdf -F format=pdf -F 'file=@fixtures/agreement.docx' http://localhost:3000/convert