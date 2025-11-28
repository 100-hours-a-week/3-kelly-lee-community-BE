# 빌드
FROM eclipse-temurin:17-jdk-alpine AS builder

WORKDIR /app

COPY gradlew .
COPY gradle gradle
COPY build.gradle settings.gradle ./

RUN chomod +x gradlew
RUN ./gradlew dependencies

COPY . .

RUN ./gradlew bootJar

# 실행
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

COPY --from=builder /app/build/libs/*.jar app.jar

EXPOSE 8080

CMD ["java","-jar","app.jar"]