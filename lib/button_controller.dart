import 'utils.dart';

class CalculatorController {
  String content = "";
  String previousAnswer = "";
  String previousCharacter = "";
  bool isDegree = true;

  bool isAllowedRepetition(String value) {
    return
      Utils.isNumber(value) ||
          value == "(" ||
          value == ")";
  }

  bool isArithmeticOperation(String value) {
    return
      value == "/" ||
          value == "x" ||
          value == "-" ||
          value == "+";
  }

  void onCalculatorButtonPress(String value) {
    // TODO: This could probably benefit from some design pattern.
    if (value == "AC") {
      content = "";
    } else if (value == "=") {
      // Pass content to an Executioner
      // Set previousAnswer
      return;
    } else if (value == "Ans") {
      content += previousAnswer;
    } else if (value == "x!") {
      content += "!";
      previousCharacter = "!";
    } else if (Utils.isFunction(value)) {
      content += "$value(";
      previousCharacter = "(";
    } else if (value == "Exp") {
      content += "10^(";
      previousCharacter = "(";
      return;
    } else if (!isAllowedRepetition(value) && value == previousCharacter) {
      // Do nothing.
      return;
    } else {
      content += value;
      previousCharacter = value;
    }
  }
}
