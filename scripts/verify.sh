#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

echo "== Toolchain =="
c3c --version
ssh -V 2>&1
node --version
python3 --version

echo "== hello =="
(cd projects/hello && c3c compile hello.c3 && ./hello)

echo "== wasm =="
(cd projects/wasm && c3c compile --target wasm32 --no-entry -o math_lib math_lib.c3 && wasm-validate math_lib.wasm)

echo "== c3-c-integration =="
make -C projects/c3-c-integration test

echo "== webserver =="
make -C projects/webserver all
python3 - <<'PY'
import socket
import subprocess
import time
import urllib.request

server = subprocess.Popen(
    ["./webserver"],
    cwd="projects/webserver",
    stdin=subprocess.PIPE,
    stdout=subprocess.PIPE,
    stderr=subprocess.STDOUT,
    text=True,
)
try:
    deadline = time.time() + 10
    while time.time() < deadline:
        try:
            with socket.create_connection(("127.0.0.1", 8080), timeout=0.5):
                break
        except OSError:
            time.sleep(0.1)
    else:
        raise SystemExit("webserver did not listen on port 8080")

    with urllib.request.urlopen("http://127.0.0.1:8080/", timeout=3) as response:
        body = response.read().decode()
        if response.status != 200 or '"status": "ok"' not in body:
            raise SystemExit(f"unexpected response: {response.status} {body}")
        print("webserver response:", body)
finally:
    server.terminate()
    try:
        output, _ = server.communicate(timeout=3)
    except subprocess.TimeoutExpired:
        server.kill()
        output, _ = server.communicate()
    print(output.strip())
PY

echo "== done =="
