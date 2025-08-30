FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    curl \
    git \
    libcurl4-openssl-dev \
    pkg-config

WORKDIR /app

COPY . /app

RUN mkdir build && cd build && cmake .. && make

EXPOSE 8080

CMD ["./build/hello_world"]


# Create a placeholder CMakeLists.txt and main.cpp if they don't exist

RUN if [ ! -f "CMakeLists.txt" ]; then \
    echo "cmake_minimum_required(VERSION 3.10)" >> CMakeLists.txt && \
    echo "project(hello_world)" >> CMakeLists.txt && \
    echo "add_executable(hello_world main.cpp)" >> CMakeLists.txt; \
fi

RUN if [ ! -f "main.cpp" ]; then \
    echo "#include <iostream>" >> main.cpp && \
    echo "#include <pistache/endpoint.h>" >> main.cpp && \
    echo "#include <pistache/http.h>" >> main.cpp && \
    echo "#include <pistache/router.h>" >> main.cpp && \
    echo "using namespace Pistache;" >> main.cpp && \
    echo "int main() {" >> main.cpp && \
    echo "  Port port(8080);" >> main.cpp && \
    echo "  Address addr(Ipv4::any(), port);" >> main.cpp && \
    echo "  Http::Endpoint server(addr);" >> main.cpp && \
    echo "  auto opts = Http::Endpoint::options().threads(1);" >> main.cpp && \
    echo "  server.init(opts);" >> main.cpp && \
    echo "  server.setHandler([](const Rest::Request&, Http::ResponseWriter response) {" >> main.cpp && \
    echo "    response.send(Http::Code::Ok, \"Hello, World!\");" >> main.cpp && \
    echo "  });" >> main.cpp && \
    echo "  server.serve();" >> main.cpp && \
    echo "  server.shutdown();" >> main.cpp && \
    echo "  return 0;" >> main.cpp; \
fi


RUN apt-get install -y libpistache-dev


RUN rm -rf build && mkdir build && cd build && cmake .. && make
