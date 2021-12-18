#!/bin/bash
PATH_TO_DOCKER=devicehive-docker/rdbms-image/
rm timelog.txt
echo "Time taken        Default         Custom" > timelog.txt
for i in `seq 1 20`;
do
	cd $PATH_TO_DOCKER
	C_START_TIME=$(date +%s)
	docker-compose -f docker-compose.yml -f dh_proxy_custom_certificate.yml up -d
	C_END_TIME=$(date +%s)
	docker-compose down
	D_START_TIME=$(date +%s)
	docker-compose -f docker-compose.yml up -d
	D_END_TIME=$(date +%s)
	docker-compose down
	C_TIME=$(($C_END_TIME - $C_START_TIME))
	D_TIME=$(($D_END_TIME - $D_START_TIME))
	cd -
	echo "		$D_TIME		$C_TIME" >> timelog.txt
done
