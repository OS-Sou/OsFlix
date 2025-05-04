#!/bin/bash

echo "Status dos containers:"
docker ps -a | grep osflix

echo -e "\nLogs do web server:"
docker logs --tail 50 osflix-web

echo -e "\nLogs do banco de dados:"
docker logs --tail 50 osflix-db 