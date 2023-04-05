import 'package:scientific_calculator/calc_parser.dart';
import 'package:test/test.dart';

void main() {
  test('extract single digit number', (){
    var tokens = Tokenizer.getTokens("2");
    expect(tokens.length, 1);
    expect(tokens[0], "2");
  });
  test('extract single digit negative number', (){
    var tokens = Tokenizer.getTokens("-2");
    expect(tokens.length, 1);
    expect(tokens[0], "-2");
  });
  test('extract multiple digit number', (){
    var tokens = Tokenizer.getTokens("2324");
    expect(tokens.length, 1);
    expect(tokens[0], "2324");
  });
  test('extract multiple digit negative number', (){
    var tokens = Tokenizer.getTokens("-2324");
    expect(tokens.length, 1);
    expect(tokens[0], "-2324");
  });
  test('extract decimal number', (){
    var tokens = Tokenizer.getTokens("2324.23");
    expect(tokens.length, 1);
    expect(tokens[0], "2324.23");
  });
  test('extract decimal negative number', (){
    var tokens = Tokenizer.getTokens("-2324.23");
    expect(tokens.length, 1);
    expect(tokens[0], "-2324.23");
  });
  test('extract number and sum', (){
    var tokens = Tokenizer.getTokens("2324.23+");
    expect(tokens.length, 2);
    expect(tokens[0], "2324.23");
    expect(tokens[1], "+");
  });
  test('extract number and sub', (){
    var tokens = Tokenizer.getTokens("2324.23-");
    expect(tokens.length, 2);
    expect(tokens[0], "2324.23");
    expect(tokens[1], "-");
  });
  test('extract number and multiplication', (){
    var tokens = Tokenizer.getTokens("2324.23*");
    expect(tokens.length, 2);
    expect(tokens[0], "2324.23");
    expect(tokens[1], "*");
  });
  test('extract number and division', (){
    var tokens = Tokenizer.getTokens("2324.23/");
    expect(tokens.length, 2);
    expect(tokens[0], "2324.23");
    expect(tokens[1], "/");
  });
  test('extract 2 numbers and a sum', (){
    var tokens = Tokenizer.getTokens("2+1");
    expect(tokens.length, 3);
    expect(tokens[0], "2");
    expect(tokens[1], "+");
    expect(tokens[2], "1");
  });
  test('extract 2 numbers and a multiplication', (){
    var tokens = Tokenizer.getTokens("2*1");
    expect(tokens.length, 3);
    expect(tokens[0], "2");
    expect(tokens[1], "*");
    expect(tokens[2], "1");
  });
  test('extract 2 numbers and parenthesis and a multiplication', (){
    var tokens = Tokenizer.getTokens("2*(1+2)");
    expect(tokens.length, 7);
    expect(tokens[0], "2");
    expect(tokens[1], "*");
    expect(tokens[2], "(");
    expect(tokens[3], "1");
    expect(tokens[4], "+");
    expect(tokens[5], "2");
    expect(tokens[6], ")");
  });
  test('extract 2 numbers and parenthesis within parenthesis and a multiplication', (){
    var tokens = Tokenizer.getTokens("2*(1+2/(1-2))");
    expect(tokens.length, 13);
    expect(tokens[0], "2");
    expect(tokens[1], "*");
    expect(tokens[2], "(");
    expect(tokens[3], "1");
    expect(tokens[4], "+");
    expect(tokens[5], "2");
    expect(tokens[6], "/");
    expect(tokens[7], "(");
    expect(tokens[8], "1");
    expect(tokens[9], "-");
    expect(tokens[10], "2");
    expect(tokens[11], ")");
    expect(tokens[12], ")");
  });
}
