# Identifier
FROM ibmcom/swift-ubuntu:3.1
MAINTAINER ustwo Fampany Ltd. https://ustwo.com/
LABEL Description="Docker image for building and running the Mockingbird sample application."

# Expose Mock Server's Port
EXPOSE 8080

# Copy Directories
COPY ./Resources /root/Resources
COPY ./Sources /root/Sources
COPY ./Tests /root/Tests
COPY ./Utility /root/Utility

# Copy Files
COPY ./Makefile /root/Makefile
COPY ./Package.pins /root/Package.pins
COPY ./Package.swift /root/Package.swift

# Perform Initial Build
RUN swift build -C /root
