up:
	docker-compose build
	docker-compose up

clean:
	docker-compose rm -vsf
	docker volume rm lava-server-pgdata lava-server-job-output
