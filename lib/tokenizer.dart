import 'symbol.dart';

class Tokenizer {
  static List<String> getTokens(String input) {
    List<String> tokenList = <String>[];
    String token = Symbols.empty;
    bool wasProcessingTerminalValue = false;
    bool previousIsEmptyOrParenthesis = true;

    for (var character in input.split(Symbols.empty)) {
      if (Symbols.isNumber(character) || character == Symbols.point) {
        previousIsEmptyOrParenthesis = false;

        if (!wasProcessingTerminalValue) {
          // previous token was a non-terminal
          wasProcessingTerminalValue = true;
          token = _saveTokenToList(token, tokenList);
        }
        token += character;
      } else {
        if (wasProcessingTerminalValue) {
          // previous token was a terminal
          wasProcessingTerminalValue = false;
          token = _saveTokenToList(token, tokenList);
        }
        if (character == Symbols.startParenthesis ||
            character == Symbols.endParenthesis) {
          previousIsEmptyOrParenthesis =
              (character == Symbols.startParenthesis);
          token = _saveTokenToList(token, tokenList);
          tokenList.add(character);
        } else {
          if (character == Symbols.subOp && previousIsEmptyOrParenthesis) {
            // This is a negative number. Append to token remaining
            // characters of terminal value.
            wasProcessingTerminalValue = true;
            previousIsEmptyOrParenthesis = false;
          }
          token += character;
        }
      }
    }
    if (token.isNotEmpty) {
      tokenList.add(token);
    }
    return tokenList;
  }

  static String _saveTokenToList(String token, List<String> tokenList) {
    if (token.isNotEmpty) {
      tokenList.add(token);
      token = Symbols.empty;
    }
    return token;
  }
}
