import 'package:berlin_demo/money.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('formats whole euros with two decimal places', () {
    expect(formatEuros(2400), '€24.00');
  });

  test('pads cents to two digits', () {
    expect(formatEuros(1205), '€12.05');
  });

  test('formats amounts below one euro', () {
    expect(formatEuros(0), '€0.00');
    expect(formatEuros(99), '€0.99');
  });

  test('puts the minus sign before the euro sign', () {
    expect(formatEuros(-2490), '-€24.90');
  });
}
