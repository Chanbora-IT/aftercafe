# Stage 1: Build JAR
FROM eclipse-temurin:21-jdk AS build
WORKDIR /app

# Copy Gradle wrapper and build files
COPY gradlew .
COPY gradle gradle
COPY gradle/wrapper gradle/wrapper
COPY build.gradle settings.gradle ./

# Make Gradle wrapper executable
RUN chmod +x gradlew

# Download dependencies and build (skip tests for speed)
RUN ./gradlew build -x test --no-daemon || true

# Copy the rest of the source code
COPY . .

# Build the JAR
RUN ./gradlew clean build -x test

# Stage 2: Run JAR
FROM eclipse-temurin:21-jdk
WORKDIR /app

COPY --from=build /app/build/libs/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
