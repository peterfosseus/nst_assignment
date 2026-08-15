# Rewards API slice

A deliberately small, dependency-free implementation of the assignment's public
health endpoint. The application listens on port `8080`; the AWS Application Load
Balancer should expose `/health` publicly and target this port in the protected
subnet.

## Run locally

Bash:

```bash
python app.py
```

Then request `http://localhost:8080/health`. Run tests with:

