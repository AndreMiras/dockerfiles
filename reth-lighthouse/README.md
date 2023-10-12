# Reth & Lighthouse

Run Reth and Lighthouse nodes.

```sh
docker compose up
```

After the first run reth will generate the JWT token in `data/reth/mainnet/jwt.hex`.
Use it to update the `JWT_SECRET_KEY` from the `.env` file.
