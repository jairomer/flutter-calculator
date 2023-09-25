typedef Symbol = String;

class Symbols {
  static const Symbol empty = "";
  static const Symbol startParenthesis = "(";
  static const Symbol endParenthesis = ")";
  static const Symbol divOp = "/";
  static const Symbol mulOp = "x";
  static const Symbol subOp = "-";
  static const Symbol addOp = "+";
  static const Symbol ac = "AC";
  static const Symbol eqOp = "=";
  static const Symbol ans = "Ans";
  static const Symbol fact = "x!";
  static const Symbol factOp = "!";
  static const Symbol sqrt = "√";
  static const Symbol inv = "Inv";
  static const Symbol tangent = "tan";
  static const Symbol cosine = "cos";
  static const Symbol sine = "sin";
  static const Symbol log = "log";
  static const Symbol ln = "ln";
  static const Symbol e = "e";
  static const Symbol exp = "Exp";
  static const Symbol consoleExp = "10^(";
  static const Symbol pow = "^";
  static const Symbol percent = "%";
  static const Symbol point = ".";

  static bool isAllowedRepetition(Symbol symb) {
    return isNumber(symb) || symb == startParenthesis || symb == endParenthesis;
  }

  static bool isArithmeticOperation(Symbol symb) {
    return symb == divOp || symb == mulOp || symb == subOp || symb == addOp;
  }

  static bool isFunction(Symbol value) {
    return value == inv ||
        value == tangent ||
        value == cosine ||
        value == sine ||
        value == log ||
        value == sqrt ||
        value == ln;
  }

  static bool isOperator(Symbol token) {
    return isFunction(token) || isArithmeticOperation(token);
  }

  static bool isNumber(Symbol value) {
    return value == "0" ||
        value == "1" ||
        value == "2" ||
        value == "3" ||
        value == "4" ||
        value == "5" ||
        value == "6" ||
        value == "7" ||
        value == "8" ||
        value == "9";
  }
}
