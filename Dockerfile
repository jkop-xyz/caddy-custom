FROM golang:1.24.1-alpine AS builder
RUN apk add --no-cache git bash curl
RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest
WORKDIR /src
COPY . .


RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/hslatman/caddy-crowdsec-bouncer/http \
    --with github.com/hslatman/caddy-crowdsec-bouncer/layer4 \
    --with github.com/hslatman/caddy-crowdsec-bouncer/appsec \
    --with github.com/greenpau/caddy-security \
    --with github.com/porech/caddy-maxmind-geolocation


FROM caddy:latest

COPY --from=builder /src/caddy /usr/bin/caddy