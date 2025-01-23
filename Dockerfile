FROM ubuntu:24.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    libeigen3-dev \
    libceres-dev \
    libopencv-dev \
    cmake \
    ninja-build

WORKDIR /app
COPY . .

# Build the project
# RUN mkdir build && cd build && cmake -G Ninja .. && ninja


# docker buildx build --platform linux/amd64,linux/arm64 -t madpose .
# docker run -it --rm madpose:latest /bin/bash