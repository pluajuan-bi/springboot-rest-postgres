# Etapa 1: Compilar
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Etapa 2: Ejecutar
# Usar una imagen base con Java
FROM openjdk:17-jdk-slim
# Crear directorio de la app
WORKDIR /app
# Copiar el JAR generado por Spring Boot
COPY --from=build /app/target/*.jar app.jar

# Exponer el puerto (el mismo que usa tu app)
EXPOSE 9082
# Comando para ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "app.jar"]