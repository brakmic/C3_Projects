module math_lib;

fn double add(double a, double b) @extern("add") @wasm {
  return a + b;
}

fn double sub(double a, double b) @extern("sub") @wasm {
  return a - b;
}

fn double mul(double a, double b) @extern("mul") @wasm {
  return a * b;
}

fn double div(double a, double b) @extern("div") @wasm {
  return a / b;
}
