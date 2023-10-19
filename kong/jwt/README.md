# Kong JWT

Kong API Gateway setup using JWT token authentication to protect an upstream service.
This can be used as a workaround until Reth authenticated RPC is live, refs:
https://github.com/paradigmxyz/reth/issues/4919

## Use

Start with:

```sh
docker compose up
```

Given the service was started with the `.env.example` values, it can later be tested with:

```sh
JWT_TOKEN=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE2OTc4MDAwNzEsImlzcyI6InBhc3N3b3JkIn0.jYSyNzkLhuflXyWswgVFmGkou1IZWz3g_pqGVyf0Nvc
curl --verbose http://localhost:8000/ \
  --header "Authorization: Bearer $JWT_TOKEN"
```
