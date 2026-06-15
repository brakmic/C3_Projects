module math_lib;

fn double add(double a, double b) @wasm {
  return a + b;
}

fn double sub(double a, double b) @wasm {
  return a - b;
}

fn double mul(double a, double b) @wasm {
  return a * b;
}

fn double div(double a, double b) @wasm {
  return a / b;
}
