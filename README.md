# C3 Projects

A collection of C3 projects demonstrating various aspects of the C3 programming language.

## Quick Start with Dev Container

This project includes a complete dev container configuration for instant setup:

### Option 1: VS Code Dev Container (Recommended)

1. Install the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) in VS Code
2. Clone this repository
3. Open the folder in VS Code
4. When prompted, click "Reopen in Container" or use `Ctrl+Shift+P` → "Dev Containers: Reopen in Container"
5. The container will automatically build and configure everything needed

### Option 2: Direct Docker Usage

```bash
# Pull the pre-built image
docker pull brakmic/c3dev:latest

# Run with volume mount
docker run -it --rm -v $(pwd):/host_workspace brakmic/c3dev:latest
```

## Dev Container Features

The `.devcontainer/` configuration provides:

### Included Tools

The base image is [brakmic/C3Dev](https://github.com/brakmic/C3Dev) on Ubuntu 26.04. `.devcontainer/Dockerfile` adds a thin layer with packages the base image does not ship (`openssh-client` and `libmicrohttpd-dev`):

- **C3 Compiler** (`c3c`) - Pinned stable release 0.8.5_1 with LSP support
- **WebAssembly Tools** (WABT) - `wasm2wat`, `wat2wasm`, `wasm-validate`, `wasm-objdump`
- **Node.js 24** (LTS) with npm, yarn, TypeScript, and development tools
- **Docker** engine for containerized development
- **Build Tools** - GCC 15, Clang/LLD, CMake, Ninja, Make
- **Debugging** - GDB, Valgrind, Strace
- **Development Utilities** - Git and Git LFS, Python 3.14, lsd, nano with syntax highlighting
- **SSH Client** - `ssh` and `ssh-keygen` for Git over SSH, added by the local layer
- **Web Server Dependencies** - libmicrohttpd development headers for the `webserver` project, added by the local layer

### VS Code Integration

- **C3 Language Extension** - Syntax highlighting and LSP support
- **Optimized Settings** - File exclusions and workspace configuration
- **Multi-folder Workspace** - Organized project structure

### Container Configuration

- **User**: `c3dev` with sudo privileges
- **Networking**: The `devnetwork` bridge network is created automatically when missing, and the container starts on it
- **Mounts**: Host workspace at `/host_workspace`; host SSH keys at `/home/c3dev/.host-ssh`, copied to `~/.ssh` with permissions `600` on attach; Docker socket for container workflows
- **Ports**: `3000` (WASM demo) and `8080` (C3 web server) are forwarded and labeled
- **Docker Socket**: Docker Desktop exposes the socket as `root:root` with mode `660`, so the container joins group `0` in `runArgs`. On a Linux host whose socket belongs to a different `docker` GID, replace `0` with that GID
- **Workspace Setup**: Automated folder structure creation plus git settings for the mounted workspace

The `setup-workspace.mjs` script automatically creates a VS Code workspace with organized folders:

- DevContainer Workspace (`/workspace`)
- Host Workspace (`/host_workspace`)
- Projects (`/host_workspace/projects`)
- Scratchpad (`/host_workspace/scratchpad`)

The host's `~/.ssh` directory must exist before the container starts because it is bind-mounted. If it does not exist, create it with `mkdir "%USERPROFILE%\.ssh"` on Windows or `mkdir -p ~/.ssh` on Linux and macOS.

The base image ships Git without the OpenSSH client. The local `.devcontainer/Dockerfile` adds `openssh-client` (and `libmicrohttpd-dev`) on top of `brakmic/c3dev:latest`; rebuild the container after editing it. Verify with `ssh -V`.

### Verify the Container

```bash
c3c --version
ssh -V
node --version
make -C projects/webserver all
make -C projects/c3-c-integration test
```

All commands should succeed without additional `apt install` steps.

## Project Examples

See the [projects directory](projects/README.md) for detailed examples including:

- Hello World program
- WebAssembly math library
- C library integration (static and shared)
- HTTP web server with JSON API
- Build instructions and usage examples

## Repository Structure

```text
/
├── .devcontainer/
│   ├── Dockerfile                 # Thin layer adding OpenSSH and libmicrohttpd
│   ├── devcontainer.json          # VS Code dev container configuration
│   └── setup-workspace.mjs        # Automated workspace setup script
├── .gitattributes                 # Repository-wide line ending rules
├── .gitignore                     # Git ignore patterns
├── README.md                      # This file
├── LICENSE                        # MIT license
├── projects/                      # Example C3 projects
│   └── README.md                  # Project documentation
└── scratchpad/                    # Local development folder (gitignored)
```

## Prerequisites (Manual Setup)

If not using the dev container, ensure you have:

- C3 compiler (`c3c`) available in your PATH
- WebAssembly Binary Toolkit (WABT) for WASM projects
- Python 3 for serving web projects

Verify your setup:

```bash
c3c --version
wasm2wat --version
python3 --version
```

## Troubleshooting

### Dev Container Issues

```bash
# Rebuild the container if extensions fail to install
# VS Code Command Palette: "Dev Containers: Rebuild Container"

# Check container logs for setup errors
docker logs <container_id>
```

If startup fails with `bind source path does not exist: /.ssh`, the host SSH directory is missing. Create it as described above. The `devnetwork` network does not need manual setup, because it is recreated automatically when absent.

If `docker info` inside the container reports `permission denied ... /var/run/docker.sock`, the container cannot reach the Docker Desktop socket. The configuration joins group `0` because Docker Desktop exposes the socket as `root:root 660`. On a Linux host where the socket belongs to a different `docker` GID, replace `0` in `runArgs` with that GID and rebuild the container.

If `ssh` is not found, the container is still running the base image. Run "Dev Containers: Rebuild Container" so the local `Dockerfile` layer is applied.

### C3 Compiler Issues

```bash
# Check if C3 is in PATH
which c3c

# Verify compiler installation
c3c --help
```

## Contributing

1. Fork the repository
2. Open in VS Code with dev containers
3. Make your changes in the containerized environment
4. Test your projects following the [project documentation](projects/README.md)
5. Submit a pull request

The dev container ensures all contributors have the same development environment.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
