_format_version: "3.0"

consumers:
  - username: admin
    jwt_secrets:
      - algorithm: HS256
        key: $KONG_JWT_PASSWORD
        secret: $KONG_JWT_SECRET

services:
  - name: default-service
    url: $KONG_SERVICE_URL
    routes:
      - name: default-route
        paths:
          - /
    plugins:
      - name: jwt
        config:
          secret_is_base64: true
