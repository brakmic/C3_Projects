# C3 Project Examples

This directory contains example C3 projects demonstrating various language features and compilation targets.

## Available Projects

### 1. Hello World (`hello/`)

A simple "Hello, World!" program demonstrating basic C3 syntax and module structure.

### 2. Math Library WASM (`wasm/`)

A mathematical library with basic arithmetic operations compiled to WebAssembly for use in web browsers.

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
lsd -lh math_lib.wasm
```

## Project Structure

```
projects/
├── README.md                      # This file
├── hello/
│   ├── hello.c3                  # Simple hello world program
│   └── hello                     # Compiled executable (after build)
└── wasm/
    ├── math_lib.c3               # Math library source
    ├── math_lib.wasm             # Compiled WASM module (after build)
    ├── math_lib.wat              # Text representation (optional)
    ├── index.html                # Web interface for testing
    └── favicons/                 # PNG favicon images
```

## Web Integration

The WASM math library exports four functions (`add`, `sub`, `mul`, `div`) that can be called from JavaScript. The included HTML file demonstrates how to load and use the WASM module in a web browser.

## Troubleshooting

### WASM Compilation Issues
```bash
# Check target support
c3c compile --list-targets

# Validate WASM output
wasm-validate math_lib.wasm
```

### Web Server Issues
```bash
# Check if port 3000 is available
netstat -tlnp | grep 3000

# Use alternative port
python3 -m http.server 8000
```

### Browser CORS Issues

Make sure to serve files via HTTP server rather than opening HTML files directly (`file://` protocol) to avoid CORS restrictions when loading WASM modules.
