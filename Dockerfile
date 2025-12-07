# 빌드
FROM eclipse-temurin:17-jdk AS builder

WORKDIR /app

COPY gradlew .
COPY gradle gradle
COPY build.gradle settings.gradle ./

RUN chmod +x gradlew
RUN ./gradlew dependencies

COPY . .

RUN ./gradlew bootJar

# 실행
FROM eclipse-temurin:17-jdk

WORKDIR /app

RUN apt-get update && apt-get install -y webp

COPY --from=builder /app/build/libs/*.jar app.jar

EXPOSE 8080

CMD ["java","-jar","app.jar"]