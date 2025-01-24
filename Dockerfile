FROM ubuntu:24.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    libeigen3-dev \
    libceres-dev \
    libopencv-dev \
    cmake \
    ninja-build \
    python3 \
    python3-pip \
    python3-venv \
    python3.12-venv \
    git \
    && rm -rf /var/lib/apt/lists/*

# # Create symbolic links for python/pip commands
RUN ln -s /usr/bin/python3 /usr/bin/python

WORKDIR /app
COPY . .

RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Build the project
RUN mkdir build && cd build && \
    cmake .. && \
    make -j4 && \
    cd ..

# run pip
RUN pip install .

# RUN mkdir build && cd build && \
#    cmake -G Ninja .. && \
#    ninja && \
#    cd .. && \
#    pip install .

CMD ["/bin/bash"]

# docker buildx build --platform linux/amd64,linux/arm64 -t madpose .
# docker run -it --rm madpose:latest /bin/bash