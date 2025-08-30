FROM alpine/glibc

RUN apk add --no-cache build-base cmake git wget zlib-dev

WORKDIR /app

RUN wget https://github.com/crowcpp/crow/archive/v1.0.tar.gz && \
    tar -xf v1.0.tar.gz && \
    rm v1.0.tar.gz && \
    cd crow-1.0 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install && \
    cd ../.. && \
    rm -rf crow-1.0

COPY main.cpp CMakeLists.txt /app/

RUN cmake . && make

CMD ["./hello_world"]


