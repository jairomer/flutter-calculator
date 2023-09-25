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
      return Symbols.empty;
    }
  }

  static String divide(String x, String y) {
    try {
      var x1 = double.parse(x);
      var y1 = double.parse(y);
      var result = x1 / y1;
      return result.toString();
    } catch (e) {
      return Symbols.empty;
    }
  }

  static String sum(String x, String y) {
    try {
      var x1 = double.parse(x);
      var y1 = double.parse(y);
      var result = x1 + y1;
      return result.toString();
    } catch (e) {
      return Symbols.empty;
    }
  }

  static String sub(String x, String y) {
    try {
      var x1 = double.parse(x);
      var y1 = double.parse(y);
      var result = x1 - y1;
      return result.toString();
    } catch (e) {
      return Symbols.empty;
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
      case Symbols.mulOp:
        return 0 == op;
      case Symbols.divOp:
        return 1 == op;
      case Symbols.addOp:
        return 2 == op;
      case Symbols.subOp:
        return 3 == op;
      default:
        return false;
    }
  }

  static String getOpString(int op) {
    switch (op) {
      case 0:
        return Symbols.mulOp;
      case 1:
        return Symbols.divOp;
      case 2:
        return Symbols.addOp;
      case 3:
        return Symbols.subOp;
      default:
        return Symbols.empty;
    }
  }
}

// Iterator solution
String? calculatorIteratorStrategy(List<Symbol> tokens) {
  if (tokens.length == 1 && Symbols.isOperator(tokens[0])) {
    return null;
  }

  var intermediate = <Symbol>[];
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
          return null;
        }
        j++;
      } else {
        intermediate.add(tokens[j]);
      }
    }
    tokens = intermediate;
    intermediate = <String>[];
  }

  if (tokens.length == 1 && !Symbols.isOperator(tokens[0])) {
    return tokens[0];
  }

  return null;
}

/// Parses the input in the calculator view and returns a Calculator object if successful.
String? compute(String input) {
  // From a tokenList, solve operations from left to right in the correct order.
  return calculatorIteratorStrategy(Tokenizer.getTokens(input));
}
