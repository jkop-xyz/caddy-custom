FROM caddy:builder-alpine AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/hslatman/caddy-crowdsec-bouncer/http \
    --with github.com/hslatman/caddy-crowdsec-bouncer/layer4 \
    --with github.com/hslatman/caddy-crowdsec-bouncer/appsec \
    --with github.com/greenpau/caddy-security \
    --with github.com/porech/caddy-maxmind-geolocation


FROM caddy:latest

COPY --from=builder /usr/bin/caddy /usr/bin/caddy