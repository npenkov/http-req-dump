FROM golang:1.14 as builder

WORKDIR /src

ENV CGO_ENABLED=0 
ENV GOARCH=amd64 
ENV GOOS=linux 

COPY . .

RUN go build -a -installsuffix cgo -o http-req-dump http-req-dump.go


FROM alpine:3.10
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*

COPY --from=builder /src/http-req-dump /opt/http-req-dump
COPY contrib/ /opt/bin/

RUN chgrp -R 0 /opt && \
    chmod -R g=u /opt /etc/passwd && \
    chmod +x /opt/bin/uid_entrypoint

WORKDIR /opt

ENTRYPOINT [ "/opt/bin/uid_entrypoint" ]

CMD ["/opt/http-req-dump"]  
