# Ref: https://github.com/sequra/logstash_exporter
FROM golang:alpine3.12 AS builder
RUN apk update \
    && apk add \
        curl \
        gcc \
        git \
        make \
    && go get -u github.com/sequra/logstash_exporter \
    && cd $GOPATH/src/github.com/sequra/logstash_exporter \
    && make vendor \
    && make build

FROM alpine:3.12
COPY --from=builder /go/src/github.com/sequra/logstash_exporter/logstash_exporter /logstash-exporter
ENTRYPOINT [ "/logstash-exporter" ]
