up:
	docker-compose build
	docker-compose up

clean:
	docker-compose rm -vsf
	docker volume rm lava-official-docker_pgdata
