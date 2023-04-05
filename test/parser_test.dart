import 'package:scientific_calculator/calc_parser.dart';
import 'package:scientific_calculator/calculator.dart';
import 'package:test/test.dart';

void main() {
  CalcParser parser = CalcParser();
  test('trivial positive: Single digit', () {
    Calculator? calc = parser.parse("1");
    expect(calc?.compute(), 1.0);
  });
  test('trivial positive: Multiple digit', () {
    Calculator? calc = parser.parse("123");
    expect(calc?.compute(), 123.0);
  });
  test('trivial positive: decimal', () {
    Calculator? calc = parser.parse("123.34");
    expect(calc?.compute(), 123.34);
  });
  test('trivial positive: decimal periodic', () {
    Calculator? calc = parser.parse("123.33333333333");
    expect(calc?.compute(), 123.33333333333);
  });
  test('trivial positive: negative digit', () {
    Calculator? calc = parser.parse("-1");
    expect(calc?.compute(), -1.0);
  });
  test('trivial positive: Negative multiple digit', () {
    Calculator? calc = parser.parse("-123");
    expect(calc?.compute(), -123.0);
  });
  test('trivial positive: negative decimal', () {
    Calculator? calc = parser.parse("-123.34");
    expect(calc?.compute(), -123.34);
  });
  test('trivial negative: Missing Terminal in product', () {
    Calculator? calc = parser.parse("1*");
    expect(calc, null);
  });
  test('trivial negative: Missing Terminal in sum', () {
    Calculator? calc = parser.parse("1+");
    expect(calc, null);
  });
  test('trivial negative: Missing Terminal in rest', () {
    Calculator? calc = parser.parse("1-");
    expect(calc, null);
  });
  test('trivial negative: Missing Terminal in division', () {
    Calculator? calc = parser.parse("1/");
    expect(calc, null);
  });
}


