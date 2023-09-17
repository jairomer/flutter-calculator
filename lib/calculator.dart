import 'package:scientific_calculator/tokenizer.dart';

class SyntaxErrorException implements Exception {
  String message;
  SyntaxErrorException(this.message);
}

/// Parses the input in the calculator view and returns a Calculator object if successful.
String? compute(String input) {
  //List<String> tokens = Tokenizer.getTokens(input);
  // From a tokenList, solve operations from left to right in the correct order.
  var tokens = Tokenizer.getTokens(input);
  if (tokens.length == 1) {
    return tokens[0];
  }
  return null;
}
