FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y build-essential cmake git wget libssl-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN git clone https://github.com/crowro/CppWebServer.git

WORKDIR /app/CppWebServer

RUN mkdir build && cd build && \
    cmake .. && \
    make

COPY . /app/CppWebServer

EXPOSE 8080

CMD ["/app/CppWebServer/build/server"]
