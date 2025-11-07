#!/bin/bash

# Colores para mensajes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # Sin color

IMAGE_NAME="springboot-rest-postgres:v1.0.0"

echo -e "${GREEN}🚀 Iniciando proceso de despliegue...${NC}"

# 1. Compilar el proyecto con Maven
echo -e "${YELLOW}🔍 Compilando proyecto con Maven...${NC}"
mvn clean package -DskipTests
if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Error al compilar el proyecto.${NC}"
    exit 1
fi

# 2. Construir la imagen Docker
echo -e "${YELLOW}🐳 Construyendo imagen Docker: $IMAGE_NAME${NC}"
docker compose build
if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Error al construir la imagen Docker.${NC}"
    exit 1
fi

# 3. Reiniciar contenedores
echo -e "${YELLOW}🔄 Reiniciando contenedores...${NC}"
docker compose down
docker compose up -d
if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Error al levantar los contenedores.${NC}"
    exit 1
fi

# 4. Mostrar logs de la aplicación
echo -e "${GREEN}📜 Mostrando logs de la aplicación...${NC}"
docker logs springboot-app --follow
