#!/usr/bin/env bash

sed -e "s|\$KONG_JWT_SECRET|$KONG_JWT_SECRET|g" \
    -e "s|\$KONG_JWT_PASSWORD|$KONG_JWT_PASSWORD|g" \
    -e "s|\$KONG_SERVICE_URL|$KONG_SERVICE_URL|g" \
    $KONG_DECLARATIVE_CONFIG.tpl > $KONG_DECLARATIVE_CONFIG

exec /docker-entrypoint.sh "$@"
