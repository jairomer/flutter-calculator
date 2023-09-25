typedef Symbol = String;

class Symbols {
  static Symbol empty = "";
  static Symbol startParenthesis = "(";
  static Symbol endParenthesis = ")";
  static Symbol divOp = "/";
  static Symbol mulOp = "x";
  static Symbol subOp = "-";
  static Symbol addOp = "+";
  static Symbol ac = "AC";
  static Symbol eqOp = "=";
  static Symbol ans = "Ans";
  static Symbol fact = "x!";
  static Symbol factOp = "!";
  static Symbol sqrt = "√";
  static Symbol inv = "Inv";
  static Symbol tangent = "tan";
  static Symbol cosine = "cos";
  static Symbol sine = "sin";
  static Symbol log = "log";
  static Symbol ln = "ln";
  static Symbol e = "e";
  static Symbol exp = "Exp";
  static Symbol consoleExp = "10^(";
  static Symbol pow = "^";
  static Symbol percent = "%";
  static Symbol point = ".";

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
