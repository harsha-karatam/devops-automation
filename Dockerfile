FROM adoptopenjdk/openjdk8:alpine-slim
EXPOSE 8050
WORKDIR /home/ks-admin/Dockerfile/numeric-0.0.1.jar
COPY numeric-0.0.1.jar /home/ks-admin/Dockerfile/numeric-0.0.1.jar
CMD ["java", "-jar", "numeric-0.0.1.jar"]
