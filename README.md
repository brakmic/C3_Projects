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

The container image is built from [brakmic/C3Dev](https://github.com/brakmic/C3Dev) on Ubuntu 26.04:

- **C3 Compiler** (`c3c`) - Pinned stable release 0.8.5_1 with LSP support
- **WebAssembly Tools** (WABT) - `wasm2wat`, `wat2wasm`, `wasm-validate`, `wasm-objdump`
- **Node.js 24** (LTS) with npm, yarn, TypeScript, and development tools
- **Docker** engine for containerized development
- **Build Tools** - GCC 15, Clang/LLD, CMake, Ninja, Make
- **Debugging** - GDB, Valgrind, Strace
- **Development Utilities** - Git and Git LFS, Python 3.14, lsd, nano with syntax highlighting

### VS Code Integration

- **C3 Language Extension** - Syntax highlighting and LSP support
- **Optimized Settings** - File exclusions and workspace configuration
- **Multi-folder Workspace** - Organized project structure

### Container Configuration

- **User**: `c3dev` with sudo privileges
- **Networking**: The `devnetwork` bridge network is created automatically when missing, and the container starts on it
- **Mounts**: Host workspace at `/host_workspace`; host SSH keys at `/home/c3dev/.host-ssh`, copied to `~/.ssh` with permissions `600` on attach
- **Workspace Setup**: Automated folder structure creation plus git settings for the mounted workspace

The `setup-workspace.mjs` script automatically creates a VS Code workspace with organized folders:

- DevContainer Workspace (`/workspace`)
- Host Workspace (`/host_workspace`)
- Projects (`/host_workspace/projects`)
- Scratchpad (`/host_workspace/scratchpad`)

The host's `~/.ssh` directory must exist before the container starts because it is bind-mounted. If it does not exist, create it with `mkdir "%USERPROFILE%\.ssh"` on Windows or `mkdir -p ~/.ssh` on Linux and macOS.

The current image ships Git without the OpenSSH client. To use Git over SSH inside the container, add `openssh-client` to the [C3Dev image](https://github.com/brakmic/C3Dev) and rebuild it.

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
│   ├── devcontainer.json          # VS Code dev container configuration
│   └── setup-workspace.mjs        # Automated workspace setup script
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
