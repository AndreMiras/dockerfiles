# Reth & Lighthouse

Run Reth and Lighthouse nodes.

## Usage

```sh
docker compose up
```

After the first run reth will generate the JWT token in `data/reth/mainnet/jwt.hex`.
Use it to update the `JWT_SECRET_KEY` from the `.env` file.

## Monitoring

Prometheus/Grafana monitoring can be enabled using the `optional` profile.

```sh
docker compose --profile optional up
```

Prometheus is served on port 9090 and Grafana on port 3000.
