#!/bin/bash

# Parar containers
echo "Parando containers..."
docker stop osflix-web osflix-db

# Remover containers
echo "Removendo containers..."
docker rm osflix-web osflix-db

# Remover rede
echo "Removendo rede..."
docker network rm osflix-network

echo "Containers parados e removidos com sucesso!" 