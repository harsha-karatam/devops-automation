FROM adoptopenjdk/openjdk8:alpine-slim
EXPOSE 8050
WORKDIR /home/ks-admin/DevOps-K8s-Security/numeric-0.0.1.jar
COPY numeric-0.0.1.jar /home/ks-admin/DevOps-K8s-Security/numeric-0.0.1.jar
CMD ["java", "-jar", "numeric-0.0.1.jar"]

