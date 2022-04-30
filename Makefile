start:
	docker-compose up -d

stop:
	docker-compose down -v --remove-orphans

build:
	docker-compose build

status:
	docker-compose ps

logs:
	docker-compose logs -f

dev:
	@echo "================================================"
	@echo "Frontend App: http://localhost:8090"
	@echo "================================================"
	# cp .env.template .env
	@make stop
	@make build
	@make start
	@make bootstrap
	@make logs

prod:
	@make stop
	@make build
	@make start
	@make logs


reset-db:
	rm -rdf data

bring-live-db:
	# Bring
	cd utils/db_import_export/fabric_script/ && .venv/bin/python3 bringdb.py
	@make reset-db
	@make dev


bring-live-certificates-from-server-to-localhost:
	# Bring
	cd utils/db_import_export/fabric_script/ && .venv/bin/python3 bring_ssl_certificates.py
	@make reset-db
	@make dev


push-v2:
	@make golive
	
golive:
	# Push v2 on server and restart
	cd utils/db_import_export/fabric_script/ && .venv/bin/python3 push_v2_latest.py

bootstrap:
	# docker-compose exec phpfe-app rm composer.lock
	# docker-compose exec phpfe-app composer update
	# docker-compose exec phpfe-app composer update --lock
	docker-compose exec -T phpfe-app composer install
	# docker-compose exec phpfe-app php artisan key:generate

pause:
	docker-compose pause

unpause:
	docker-compose unpause

app-sh:
	docker-compose exec phpfe-app /bin/bash

mysql-sh:
	docker-compose exec mysqldb /bin/bash

php-myadmin:
	open "http://pma.localhost"


dokcer-previliges-fix:
	groupadd docker
	gpasswd -a $USER docker
	echo "Logout and logback in"
	service docker restart

server-pull:
	git status
	git stash
	git pull
	@make dev



renew-certs:
	cd utils/certbot/ && sudo ./server-certbot-renew.sh
	@make dev