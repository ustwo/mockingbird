# Identifier
FROM ibmcom/swift-ubuntu:latest
MAINTAINER ustwo Fampany Ltd. https://ustwo.com/
LABEL Description="Docker image for building and running the Mockingbird sample application."

# Expose Mock Server's Port
EXPOSE 8090

# Copy Directories
COPY ./Resources /root/Resources
COPY ./Sources /root/Sources
COPY ./Tests /root/Tests
COPY ./Utility /root/Utility

# Copy Files
COPY ./Package.swift /root/Package.swift

# Perform Initial Build
RUN swift build -C /root
