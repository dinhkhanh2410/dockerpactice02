FROM golang:alpine as build

WORKDIR /app

COPY go.mod .

COPY go.sum .

RUN go mod download

COPY . .

RUN go build -o api


##

FROM alpine:latest

WORKDIR /app

COPY --from=build /app/api .
COPY .env .

CMD ["./api"]

