FROM golang:1.20.2-alpine AS build

WORKDIR /app

ADD main.go /app/main.go

RUN CGO_ENABLED=0 GOOS=linux go build -o /test-app main.go

FROM alpine:3.17

EXPOSE 8080

COPY --from=build /test-app /test-app

CMD ["/test-app"]