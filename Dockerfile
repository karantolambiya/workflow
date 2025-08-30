FROM gcc:latest

WORKDIR /app

COPY . /app

RUN apt-get update && apt-get install -y libmicrohttpd-dev

RUN gcc -o main main.c -lmicrohttpd

EXPOSE 8080

CMD ["./main"]
