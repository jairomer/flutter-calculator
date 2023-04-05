class Constants {
  static const sqrt = "√";
}

class MyMath {
  static double floor(double d) {
    return d - (d%1);
  }
}

class Utils {
  static bool isFunction(String value) {
    return value == "Inv" ||
        value == "tan" ||
        value == "cos" ||
        value == "sin" ||
        value == "log" ||
        value == Constants.sqrt ||
        value == "ln";
  }
  static bool isOperator(String token) {
    return isFunction(token) ||
        token == "*" ||
        token == "+" ||
        token == "/" ||
        token == "-";
  }
  static bool isNumber(String value) {
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

/// A pair of values
class Pair<E, F> {
  E first;
  F last;

  Pair(this.first, this.last);

  @override
  String toString() => '($first, $last)';

  @override
  bool operator ==(other) {
    if (other is! Pair) return false;
    return other.first == first && other.last == last;
  }

  @override
  int get hashCode => first.hashCode ^ last.hashCode;

}