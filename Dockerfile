# Use golang:1.22 como construtor
FROM golang:1.22.2 as BUILDER

# Defina o diretório de trabalho no construtor
WORKDIR /app

# Copie o diretório 'cmd' do diretório atual para o diretório 'app' no construtor
# Se o diretório 'cmd' não estiver no diretório atual, substitua '.' pelo caminho correto
COPY ./cmd ./cmd

# Copie o arquivo go.mod
COPY go.mod .

COPY go.sum .
# Copie o arquivo main.go
COPY main.go .

# Construa a aplicação
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GO111MODULE=on GOOS=linux go build -o trecepage . 

# Use golang:1.22-alpine como executor
FROM golang:1.22.2-alpine as RUNNER

# Copie a aplicação construída do construtor para o executor
COPY --from=BUILDER /app/trecepage .

# Exponha a porta 8080
EXPOSE 8080

# Execute a aplicação
CMD ["./trecepage"]
