#include <stdio.h>
#include "mathlib.h"

double add(double a, double b) {
    return a + b;
}

double multiply(double a, double b) {
    return a * b;
}

int factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}
