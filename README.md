![CI](https://github.com/Griffindeetox/docker-mini/actions/workflows/ci.yml/badge.svg)

# docker-mini (Node + Redis via Docker Compose)

A tiny service that demonstrates container best practices:
- Multi-stage Dockerfile with **non-root** user
- Container **HEALTHCHECK** hitting `/health`
- **Redis** sidecar + **named volume** for persistence
- Simple stateful endpoint: `/incr`

## Run locally
```bash
docker compose up -d --build
curl -s http://localhost:3000/health   # {"status":"ok"}
curl -s http://localhost:3000/incr     # {"counter":1}
