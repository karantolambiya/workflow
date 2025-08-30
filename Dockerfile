FROM alpine/git

RUN apk add --no-cache build-base libc-dev linux-headers

RUN git clone https://github.com/wolfeidau/c-example-web-app.git /app

WORKDIR /app

RUN make

EXPOSE 3000

CMD ["./bin/example-app"]
