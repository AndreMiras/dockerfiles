# Reth & Lighthouse

Run Reth and Lighthouse nodes.

## Usage

```sh
docker compose up
```

After the first run reth will generate the JWT token in
`data/reth/mainnet/jwt.hex`. Use it to update the `JWT_SECRET_KEY` from the
`.env` file.

## Monitoring

Prometheus/Grafana monitoring can be enabled using the `optional` profile.

```sh
docker compose --profile optional up
```

Prometheus is served on port 9090 and Grafana on port 3000.

## Systemd service

Update the `WorkingDirectory` path in `docker-compose-reth-lighthouse.service`.
Then copy it over before enabling and starting it.

```sh
cp docker-compose-reth-lighthouse.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable docker-compose-reth-lighthouse
sudo systemctl start docker-compose-reth-lighthouse
```

Check status and logs:

```sh
sudo systemctl status docker-compose-reth-lighthouse
sudo journalctl -u docker-compose-reth-lighthouse --follow --output cat
```
