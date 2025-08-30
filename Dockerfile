FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libcrow-dev \
    git \
    curl

WORKDIR /app

COPY . /app

RUN mkdir build && cd build && cmake .. && make

EXPOSE 8080

CMD ["./build/hello_world"]
