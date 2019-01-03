up: files
	docker-compose build
	docker-compose up

files:
	mkdir -p images/kvm/standard
	wget -P images/kvm/standard/ http://images.validation.linaro.org/kvm/standard/large-stable-6.img.gz

clean:
	docker-compose rm -vsf
	docker volume rm lava-official-docker_pgdata
