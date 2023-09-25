import 'package:scientific_calculator/symbol.dart';
import 'package:scientific_calculator/tokenizer.dart';

class SyntaxErrorException implements Exception {
  String message;
  SyntaxErrorException(this.message);
}

class Operations {
  static const int definedOpsCount = 4;

  static String multiply(String x, String y) {
    try {
      var x1 = double.parse(x);
      var y1 = double.parse(y);
      var result = x1 * y1;
      return result.toString();
    } catch (e) {
      return "";
    }
  }

  static String divide(String x, String y) {
    try {
      var x1 = double.parse(x);
      var y1 = double.parse(y);
      var result = x1 / y1;
      return result.toString();
    } catch (e) {
      return "";
    }
  }

  static String sum(String x, String y) {
    try {
      var x1 = double.parse(x);
      var y1 = double.parse(y);
      var result = x1 + y1;
      return result.toString();
    } catch (e) {
      return "";
    }
  }

  static String sub(String x, String y) {
    try {
      var x1 = double.parse(x);
      var y1 = double.parse(y);
      var result = x1 - y1;
      return result.toString();
    } catch (e) {
      return "";
    }
  }

  static String operate(String x, String y, int i) {
    switch (i % 4) {
      case 0:
        return Operations.multiply(x, y);
      case 1:
        return Operations.divide(x, y);
      case 2:
        return Operations.sum(x, y);
      case 3:
        return Operations.sub(x, y);
      default:
        return "";
    }
  }

  static bool isOperation(String i, int op) {
    switch (i) {
      case "*":
        return 0 == op;
      case "/":
        return 1 == op;
      case "+":
        return 2 == op;
      case "-":
        return 3 == op;
      default:
        return false;
    }
  }

  static String getOpString(int op) {
    switch (op) {
      case 0:
        return "*";
      case 1:
        return "/";
      case 2:
        return "+";
      case 3:
        return "-";
      default:
        return "";
    }
  }

  static bool isOp(String op) {
    return op == '*' || op == '/' || op == '+' || op == '-';
  }
}

// Iterator solution
String? calculatorIteratorStrategy(List<String> tokens) {
  if (tokens.length == 1 && Operations.isOp(tokens[0])) {
    // (tokens[0] == '*' || tokens[0] == '/')) {
    return null;
  }

  var intermediate = <String>[];
  //print("$tokens");
  for (int op = 0; op < Operations.definedOpsCount; op++) {
    for (int j = 0; j < tokens.length; j++) {
      if (j > 0 &&
          j < tokens.length - 1 &&
          Operations.isOperation(tokens[j], op)) {
        intermediate[intermediate.length - 1] = Operations.operate(
            intermediate[intermediate.length - 1], tokens[j + 1], op);
        //print("value: ${tokens[j + 1]}");
        //print("last: ${intermediate[intermediate.length - 1]}");
        //print("op: ${Operations.getOpString(op)}");
        if (tokens[j] == "") {
          //print(
              "Cannot operate: ${intermediate.first}, ${Operations.getOpString(op)}  ${tokens[j + 1]}");
          return null;
        }
        j++;
      } else {
        intermediate.add(tokens[j]);
      }
    }
    tokens = intermediate;
    //print("$tokens");
    intermediate = <String>[];
  }

  if (tokens.length == 1 && !Symbols.isOperator(tokens[0])) {
    return tokens[0];
  }

  //print(tokens);
  return null;
}

/// Parses the input in the calculator view and returns a Calculator object if successful.
String? compute(String input) {
  // From a tokenList, solve operations from left to right in the correct order.
  return calculatorIteratorStrategy(Tokenizer.getTokens(input));
}
