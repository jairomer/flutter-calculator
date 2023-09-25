import 'package:scientific_calculator/calculator.dart';
import 'package:test/test.dart';

void main() {
  test('trivial positive case: Single digit', () {
    expect(compute("1.0"), "1.0");
  });
  test('trivial positive case: Multiple digit', () {
    expect(compute("123"), "123");
  });
  test('trivial positive case: decimal', () {
    expect(compute("123.34"), "123.34");
  });
  test('trivial positive case: decimal periodic', () {
    expect(compute("123.33333333333"), "123.33333333333");
  });
  test('trivial positive case: negative digit', () {
    expect(compute("-1"), "-1");
  });
  test('trivial positive case: Negative multiple digit', () {
    expect(compute("-123"), "-123");
  });
  test('trivial positive case: negative decimal', () {
    expect(compute("-123.34"), "-123.34");
  });
  test('trivial negative case: Single nonterminal', () {
    expect(compute("*"), null);
  });
  test('trivial negative case: Single nonterminal', () {
    expect(compute("/"), null);
  });
  test('trivial negative case: Missing Terminal in product', () {
    expect(compute("1*"), null);
  });
  test('trivial negative case: Missing Terminal in sum', () {
    expect(compute("1+"), null);
  });
  test('trivial negative case: Missing Terminal in rest', () {
    expect(compute("1-"), null);
  });
  test('trivial negative case: Missing Terminal in division', () {
    expect(compute("1/"), null);
  });
  test('trivial case: Sum of two positive digits', () {
    expect(compute("1+1"), "2.0");
  });
  test('trivial case: Product of two positive digits', () {
    expect(compute("1*1"), "1.0");
  });
  test('trivial case: Product of two positive digits', () {
    expect(compute("2*1"), "2.0");
  });
  test('trivial case: Division of two positive digits', () {
    expect(compute("1/1"), "1.0");
  });
  test('trivial case: Division of two positive digits', () {
    expect(compute("2/1"), "2.0");
  });
  test('case: Sum and multiplication of two positive digits', () {
    expect(compute("1+2*1"), "3.0");
  });
  test('case: Sum and multiplication of two positive digits', () {
    expect(compute("2*1+1"), "3.0");
  });
  test('case: Sum, multiplication and substraction of three positive digits',
      () {
    expect(compute("2*1+1-5"), "-2.0");
  });
  test(
      'case: Sum, multiplication and substraction of two positive digits and one floating point value',
      () {
    expect(compute("2*1+1-5.5"), "-2.5");
  });
}
