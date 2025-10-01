# Stage 1: Build JAR
FROM eclipse-temurin:21-jdk AS build
WORKDIR /app

# Copy Gradle wrapper and configs first
COPY gradlew .
COPY gradle gradle
COPY gradle/wrapper gradle/wrapper
COPY build.gradle settings.gradle ./

# Fix permissions + line endings for gradlew
RUN sed -i 's/\r$//' gradlew && chmod +x gradlew

# Pre-download dependencies (optional)
RUN ./gradlew build -x test --no-daemon || true

# Now copy the rest of the source code
COPY . .

# Fix permissions AGAIN after copying everything (important!)
RUN sed -i 's/\r$//' gradlew && chmod +x gradlew

# Build the JAR
RUN ./gradlew clean bootJar -x test --no-daemon

# Stage 2: Run JAR
FROM eclipse-temurin:21-jdk
WORKDIR /app

COPY --from=build /app/build/libs/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
