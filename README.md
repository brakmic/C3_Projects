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
- **C3 Compiler** (`c3c`) - Latest stable release with LSP support
- **WebAssembly Tools** (`wasm2wat`, `wasm-validate`, `wasm-objdump`)
- **Node.js 22** with npm, yarn, TypeScript, and development tools
- **Docker** engine for containerized development
- **Build Tools** - GCC 14, CMake, Ninja, Make
- **Development Utilities** - Git, Python 3, lsd, nano with syntax highlighting

### VS Code Integration
- **C3 Language Extension** - Syntax highlighting and LSP support
- **Optimized Settings** - File exclusions and workspace configuration
- **Multi-folder Workspace** - Organized project structure

### Container Configuration
- **User**: `c3dev` with sudo privileges
- **Networking**: Custom Docker network for multi-container development
- **Mounts**: Host workspace accessible at `/host_workspace`
- **Workspace Setup**: Automated folder structure creation

The `setup-workspace.mjs` script automatically creates a VS Code workspace with organized folders:
- DevContainer Workspace (`/workspace`)
- Host Workspace (`/host_workspace`) 
- Projects (`/host_workspace/projects`)
- Scratchpad (`/host_workspace/scratchpad`)

## Project Examples

See the [projects directory](projects/README.md) for detailed examples including:
- Hello World program
- WebAssembly math library
- Build instructions and usage examples

## Repository Structure

```
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
