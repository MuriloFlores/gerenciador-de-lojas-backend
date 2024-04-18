FROM golang:1.22 as BUILDER

WORKDIR /app

COPY cmd cmd
COPY go.mod go.mod
COPY main.go main.go

RUN go build -o trecepage .

FROM golang:1.22-alpine as RUNNER

COPY --from=BUILDER /app/trecepage .

EXPOSE 8080

CMD ["./trecepage"]