# 빌드
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

COPY build.gradle settings.gradle gradlew ./
RUN chomod +x gradlew
RUN ./gradlew dependencies

COPY . .

RUN ./gradlew bootJar

# 실행
FROM openjdk:17-jdk-slim

WORKDIR /app

COPY --from=builder /app/build/libs/*.jar app.jar

EXPOSE 8080

CMD ["java","-jar","app.jar"]