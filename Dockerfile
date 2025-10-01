# Stage 1: Build JAR
FROM eclipse-temurin:21-jdk AS build
WORKDIR /app

# Copy everything
COPY . .

# Make Gradle wrapper executable
RUN chmod +x gradlew

# Build the JAR
RUN ./gradlew clean build -x test

# Stage 2: Run JAR
FROM eclipse-temurin:21-jdk
WORKDIR /app

# Copy JAR from build stage
COPY --from=build /app/build/libs/*.jar app.jar

# Expose port
EXPOSE 8080

# Run Spring Boot app
ENTRYPOINT ["java", "-jar", "app.jar"]