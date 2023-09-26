import 'package:scientific_calculator/symbol.dart';
import 'package:scientific_calculator/tokenizer.dart';

abstract class Operation {
  Symbol symbol();
  String apply(String x, String y);
}

class Multiplication implements Operation {
  @override
  Symbol symbol() { return Symbols.mulOp; }

  @override
  String apply(String x, String y) {
    try {
      var x1 = double.parse(x);
      var y1 = double.parse(y);
      var result = x1 * y1;
      return result.toString();
    } catch (e) {
      return Symbols.empty;
    }
  }
}

class Division implements Operation {
  @override
  Symbol symbol() { return Symbols.divOp; }

  @override
  String apply(String x, String y) {
    try {
      var x1 = double.parse(x);
      var y1 = double.parse(y);
      var result = x1 / y1;
      return result.toString();
    } catch (e) {
      return Symbols.empty;
    }
  }
}

class Addition implements Operation {
  @override
  Symbol symbol() { return Symbols.addOp; }

  @override
  String apply(String x, String y) {
    try {
      var x1 = double.parse(x);
      var y1 = double.parse(y);
      var result = x1 + y1;
      return result.toString();
    } catch (e) {
      return Symbols.empty;
    }
  }
}

class Substraction implements Operation {
  @override
  Symbol symbol() { return Symbols.subOp; }

  @override
  String apply(String x, String y) {
    try {
      var x1 = double.parse(x);
      var y1 = double.parse(y);
      var result = x1 - y1;
      return result.toString();
    } catch (e) {
      return Symbols.empty;
    }
  }
}

class Operations {

  List<Operation> operations = <Operation>[];

  Operations() {
    // Add new operations here.
    operations.add(Multiplication());
    operations.add(Division());
    operations.add(Addition());
    operations.add(Substraction());
  }

  int operationsCount() {
    return operations.length;
  }

  String operate(String x, String y, int i) {
    return operations[i%operations.length].apply(x, y);
  }

  bool isOperation(String i, int op) {
    return operations[op].symbol() == i;
  }

  String getOpString(int op) {
    return operations[op].symbol();
  }
}

// Iterator solution
String? calculatorIteratorStrategy(List<Symbol> tokens) {
  if (tokens.length == 1 && Symbols.isOperator(tokens[0])) {
    return null;
  }

  Operations operations = Operations();

  var intermediate = <Symbol>[];
  for (int op = 0; op < operations.operationsCount(); op++) {
    for (int j = 0; j < tokens.length; j++) {
      if (j > 0 &&
          j < tokens.length - 1 &&
          operations.isOperation(tokens[j], op)) {
        intermediate[intermediate.length - 1] = operations.operate(
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
