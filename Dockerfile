# Stage 1: A temporary, lightweight downloader
FROM alpine:latest AS downloader
RUN apk add --no-cache curl
# Download a highly stable version of the Postgres JDBC Driver
RUN curl -o /postgresql-42.6.0.jar https://jdbc.postgresql.org/download/postgresql-42.6.0.jar

# Stage 2: The actual Spark image
FROM tabulario/spark-iceberg:latest
# Bypasses user restrictions and injects the file directly into the JVM classpath
COPY --from=downloader /postgresql-42.6.0.jar /opt/spark/jars/postgresql-42.6.0.jar
