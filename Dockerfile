FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    curl \
    libcurl4-openssl-dev \
    libboost-all-dev

WORKDIR /app

COPY . /app

RUN mkdir build && cd build && cmake .. && make

CMD ["./build/hello_world"]


# Create a dummy hello_world.cpp if one doesn't exist in provided context
RUN if [ ! -f "hello_world.cpp" ]; then \
    echo "#include <iostream>\n#include <boost/asio.hpp>\n\nint main() {\n  try {\n    boost::asio::io_context io_context;\n    boost::asio::ip::tcp::acceptor acceptor(io_context, boost::asio::ip::tcp::endpoint(boost::asio::ip::tcp::v4(), 8080));\n\n    while (true) {\n      boost::asio::ip::tcp::socket socket(io_context);\n      acceptor.accept(socket);\n\n      std::string message = \"HTTP/1.1 200 OK\\r\\nContent-Type: text/plain\\r\\nContent-Length: 13\\r\\n\\r\\nHello, World!\";\n      boost::asio::write(socket, boost::asio::buffer(message));\n    }\n  } catch (std::exception& e) {\n    std::cerr << \"Exception: \" << e.what() << \"\\n\";\n  }\n\n  return 0;\n}" > hello_world.cpp; \
fi

EXPOSE 8080
