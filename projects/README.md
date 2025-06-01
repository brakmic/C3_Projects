# C3 Project Examples

This directory contains example C3 projects demonstrating various language features and compilation targets.

## Available Projects

### 1. Hello World (`hello/`)

A simple "Hello, World!" program demonstrating basic C3 syntax and module structure.

### 2. Math Library WASM (`wasm/`)

A mathematical library with basic arithmetic operations compiled to WebAssembly for use in web browsers.

### 3. C3-C Integration (`c3-c-integration/`)

A demonstration of C library integration with C3, showing how to bind and call C functions from C3 code using both static and shared libraries.

### 4. Web Server (`webserver/`)

A minimal HTTP web server built with C3 using libmicrohttpd, featuring JSON API endpoints.

## Building and Running Projects

### Hello World Project

Navigate to the hello directory and compile:
```bash
cd hello
c3c compile hello.c3
./hello
```

Expected output:
```
Hello, world!
```

### Math Library WASM Project

#### Step 1: Compile to WebAssembly
```bash
cd wasm
c3c compile --target wasm32 -o math_lib math_lib.c3
```

#### Step 2: Verify WASM compilation
```bash
# Check if WASM file was created
ls -la math_lib.wasm

# Validate the WASM file
wasm-validate math_lib.wasm

# Convert to text format for inspection (optional)
wasm2wat math_lib.wasm -o math_lib.wat
```

#### Step 3: Serve the web application
```bash
# Start Python HTTP server in the wasm directory
python3 -m http.server 3000
```

#### Step 4: Open in browser
```bash
# Open the web application
"$BROWSER" http://localhost:3000
```

The web page will load the WASM module and test the mathematical functions (add, subtract, multiply, divide) with sample values.

### C3-C Integration Project

#### Step 1: Build the C library and C3 executable
```bash
cd c3-c-integration
make all
```

#### Step 2: Run the demonstrations
```bash
# Run static library version
./c3_static_demo

# Run shared library version (requires library path)
LD_LIBRARY_PATH=. ./c3_shared_demo
```

#### Manual compilation
```bash
# Compile C library
gcc -c -fPIC mathlib.c -o mathlib.o
ar rcs libmath.a mathlib.o

# Compile C3 with static library
c3c compile main.c3 -l libmath.a -L . -o demo
```

### Web Server Project

#### Step 1: Install dependencies
```bash
# Install libmicrohttpd development library
apt update && apt install -y libmicrohttpd-dev
```

#### Step 2: Build and run the server
```bash
cd webserver
c3c compile -l microhttpd -o webserver webserver.c3
./webserver
```

#### Step 3: Test the server
```bash
# In another terminal, test the API
curl http://localhost:8080

# Test in browser
"$BROWSER" http://localhost:8080
```

Expected output:
```json
{"message": "Hello from C3!", "status": "ok"}
```

### Advanced WASM Development

#### Inspecting WASM exports
```bash
# List exported functions
wasm-objdump -x math_lib.wasm

# Decompile to readable format
wasm-decompile math_lib.wasm -o math_lib.dcmp
```

#### Optimization options
```bash
# Compile with optimization
c3c compile --target wasm32 -O3 -o math_lib math_lib.c3

# Check file size difference
ls -lh math_lib.wasm
```

## Project Structure

```
projects/
├── README.md                      # This file
├── hello/
│   ├── hello.c3                  # Simple hello world program
│   └── hello                     # Compiled executable (after build)
├── wasm/
│   ├── math_lib.c3               # Math library source
│   ├── math_lib.wasm             # Compiled WASM module (after build)
│   ├── math_lib.wat              # Text representation (optional)
│   ├── index.html                # Web interface for testing
│   └── favicons/                 # PNG favicon images
├── c3-c-integration/
│   ├── mathlib.h                 # C library header
│   ├── mathlib.c                 # C library implementation
│   ├── main.c3                   # C3 code using the C library
│   ├── Makefile                  # Build automation
└── webserver/
    ├── webserver.c3              # HTTP server implementation
    └── favicon.ico               # Optional favicon file
```

## Key Features Demonstrated

### Language Features
- **Basic syntax and modules** (hello)
- **WebAssembly compilation** (wasm)
- **C library integration** (c3-c-integration)
- **Network programming** (webserver)

### Integration Capabilities
- **Web browser compatibility** via WASM
- **C library interoperability** with external function bindings
- **HTTP server development** using system libraries
- **Static and shared library linking**

## Web Integration

### WASM Module
The WASM math library exports four functions (`add`, `sub`, `mul`, `div`) that can be called from JavaScript. The included HTML file demonstrates how to load and use the WASM module in a web browser.

### HTTP Server
The web server project creates a REST API that responds with JSON data, demonstrating how C3 can be used for backend web development.

## Troubleshooting

### WASM Compilation Issues
```bash
# Check target support
c3c compile --list-targets

# Validate WASM output
wasm-validate math_lib.wasm
```

### C Library Integration Issues
```bash
# Check if C library compiled correctly
file libmath.a libmath.so

# Verify C3 can find the library
c3c compile main.c3 -l:libmath.a -L. --verbose

# Check library symbols
nm libmath.a
```

### Web Server Issues
```bash
# Check if libmicrohttpd is installed
dpkg -l | grep microhttpd

# Test if port 8080 is available
netstat -tlnp | grep 8080

# Check server compilation
ldd webserver  # View linked libraries
```

### General Issues
```bash
# Check C3 compiler version
c3c --version

# Use alternative port for web servers
python3 -m http.server 8000
```

### Browser CORS Issues

Make sure to serve files via HTTP server rather than opening HTML files directly (`file://` protocol) to avoid CORS restrictions when loading WASM modules.
