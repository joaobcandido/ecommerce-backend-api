# Estágio 1: Build da aplicação com Maven Wrapper (usando Java 25)
FROM eclipse-temurin:25-jdk-jammy AS build
WORKDIR /app
COPY . .
RUN ./mvnw clean package -DskipTests

# Estágio 2: Execução da aplicação leve (usando JRE 25)
FROM eclipse-temurin:25-jre-jammy
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
