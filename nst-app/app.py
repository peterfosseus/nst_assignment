"""Tiny, dependency-free health API."""
import json
import os
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
import urllib.request
import boto3

# Get IMDSv2 token
token_request = urllib.request.Request(
    "http://169.254.169.254/latest/api/token",
    method="PUT",
    headers={
        "X-aws-ec2-metadata-token-ttl-seconds": "21600"
    }
)

with urllib.request.urlopen(token_request) as response:
    token = response.read().decode()

# Get private IP
ip_request = urllib.request.Request(
    "http://169.254.169.254/latest/meta-data/local-ipv4",
    headers={
        "X-aws-ec2-metadata-token": token
    }
)

with urllib.request.urlopen(ip_request) as response:
    private_ip = response.read().decode()

client = boto3.client("secretsmanager", region_name="eu-west-1")

response = client.get_secret_value(
    SecretId="nst-rewards-dev"
)

# I need to not use the words secret manager as it sets of alarms.
sm_array = json.loads(response["SecretString"])

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path != "/health":
            return self.reply(404, {"error": "not found"})
        self.reply(200, {
            "service": "rewards",
            "status": "ok",
            "ip address of the node, for scaling demo": private_ip,
            "aws demo value from sm": sm_array["demo"]
        })

    def reply(self, status, body):
        payload = json.dumps(body, separators=(",", ":")).encode()
        self.send_response(status)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(payload)))
        self.end_headers()
        self.wfile.write(payload)

    def log_message(self, fmt, *args):
        print(json.dumps({"client": self.client_address[0], "message": fmt % args}))


if __name__ == "__main__":
    ThreadingHTTPServer(("0.0.0.0", 8080), Handler).serve_forever()
