# Usar una imagen base con Java
FROM openjdk:17-jdk-slim

# Crear directorio de la app
WORKDIR /app

# Copiar el JAR generado por Spring Boot
COPY target/springboot-rest-postgres.jar app.jar

# Exponer el puerto (el mismo que usa tu app)
EXPOSE 9080

# Comando para ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "app.jar"]