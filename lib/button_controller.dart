import 'package:scientific_calculator/calculator.dart';

import 'symbol.dart';

class CalculatorController {
  String content = "";
  String previousAnswer = "";
  String previousCharacter = "";
  bool isDegree = true;

  void onCalculatorButtonPress(String value) {
    if (value == Symbols.ac) {
      content = Symbols.empty;
    } else if (value == Symbols.eqOp) {
      String? result = compute(content);
      if (result != null) {
        content = result;
      }
      return;
    } else if (value == Symbols.ans) {
      content += previousAnswer;
    } else if (value == Symbols.fact) {
      content += Symbols.factOp;
      previousCharacter = Symbols.factOp;
    } else if (Symbols.isFunction(value)) {
      content += value + Symbols.startParenthesis;
      previousCharacter = Symbols.startParenthesis;
    } else if (value == Symbols.exp) {
      content += Symbols.consoleExp;
      previousCharacter = Symbols.startParenthesis;
      return;
    } else if (!Symbols.isAllowedRepetition(value) &&
        value == previousCharacter) {
      // Do nothing.
      return;
    } else {
      content += value;
      previousCharacter = value;
    }
  }
}
