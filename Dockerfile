FROM openjdk:17-jdk-alpine

WORKDIR /app

COPY pom.xml .

RUN mvn dependency:go-offline

COPY src .

RUN mvn package

EXPOSE 8080

CMD ["java", "-jar", "target/dependency/webapp-runner.jar", "--port", "8080", "target/*.war"]
