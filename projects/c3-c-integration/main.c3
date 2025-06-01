module main;

import std::io;

// C library bindings
extern fn double add(double a, double b) @extern("add");
extern fn double multiply(double a, double b) @extern("multiply");
extern fn int factorial(int n) @extern("factorial");

fn void main() {
    double result1 = add(10.5, 20.3);
    io::printfn("C3 received result: %.2f", result1);
    
    double result2 = multiply(4.5, 3.2);
    io::printfn("C3 received result: %.2f", result2);
    
    int fact_result = factorial(5);
    io::printfn("C3 received factorial: %d", fact_result);
}
