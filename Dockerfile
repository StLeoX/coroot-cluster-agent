FROM golang:1.23-bullseye AS builder
WORKDIR /tmp/src
COPY go.mod .
COPY go.sum .
RUN export GOPROXY='https://goproxy.cn' && go mod download
COPY . .
ARG VERSION=latest
RUN go build -mod=readonly -ldflags "-X main.version=$VERSION" -o coroot-cluster-agent .


FROM debian:bullseye
RUN apt update && apt install -y ca-certificates

COPY --from=builder /tmp/src/coroot-cluster-agent /usr/bin/coroot-cluster-agent

ENTRYPOINT ["coroot-cluster-agent"]
