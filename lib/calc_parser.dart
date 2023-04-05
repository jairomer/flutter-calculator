import 'package:scientific_calculator/stack.dart';

import 'calculator.dart';
import 'computation_node_I.dart';
import 'utils.dart';
import 'operations.dart';

class Tokenizer {
  static List<String> getTokens(String input) {
    List<String> tokenList = <String>[];
    String token = "";
    bool wasProcessingTerminalValue = false;
    bool previousIsEmptyOrParenthesis = true;
    for (var character in input.split("")) {
      if (Utils.isNumber(character) || character == ".") {
        previousIsEmptyOrParenthesis = false;
        if (!wasProcessingTerminalValue) {
          // previous token was a non-terminal
          wasProcessingTerminalValue = true;
          token = saveTokenToList(token, tokenList);
        }
        token += character;
      } else {
        if (wasProcessingTerminalValue) {
          // previous token was a terminal
          wasProcessingTerminalValue = false;
          token = saveTokenToList(token, tokenList);
        }
        if (character == "(" || character == ")") {
          previousIsEmptyOrParenthesis = (character == "(");
          token = saveTokenToList(token, tokenList);
          tokenList.add(character);
        } else {
          if (character == "-" && previousIsEmptyOrParenthesis) {
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

  static String saveTokenToList(String token, List<String> tokenList) {
    if (token.isNotEmpty) {
      tokenList.add(token);
      token = "";
    }
    return token;
  }
}

class SyntaxErrorException implements Exception {
  String message;
  SyntaxErrorException(this.message);
}

/// Parses the input in the calculator view and returns a Calculator object if successful.
class CalcParser {
  OperationI? tryParseOperationNode(String token, int depth) {
    OperationI operation;
    switch (token) {
      case "+":
        operation = SumOperation();
        operation.setPriority(0 + depth);
        break;
      case "-":
        operation = SubsOperation();
        operation.setPriority(0 + depth);
        break;
      case "/":
        operation = DivOperation();
        operation.setPriority(1 + depth);
        break;
      case "*":
        operation = MultOperation();
        operation.setPriority(1 + depth);
        break;
      default:
        return null;
    }
    return operation;
  }

  FunctionNode? tryParseFunctionNode(String token) {
    // TODO
    return null;
  }

  ValueNode? tryParseValueNode(String token) {
    double? value = double.tryParse(token);
    return (value == null) ? null : ValueNode(value);
  }



  /// In order to parse the computation:
  /// - Tokenize the input.
  /// - Convert each token into a ComputationNode
  /// - Insert these ComputationNode from left to right into a
  ///   computation tree.
  ///   + If an error is returned, then the input cannot be parsed.
  Calculator? parse(String input) {
    var tokenList = Tokenizer.getTokens(input);

    int parenthesisDepth = 0;
    OperationBuilder rootBuilder = OperationBuilder();
    Stack<ComputationContext> contextStack = Stack();
    ComputationContext root = ComputationContext(rootBuilder);
    contextStack.push(root);

    if (tokenList.length == 1) {
      // If there is only one token, it needs to be a value.
      var value = tryParseValueNode(tokenList.first);
      if (value==null) {
        print("syntax error: single value needs to be a value");
        return null;
      }
      return Calculator(value);
    }
    for (var token in tokenList) {
      if (token == "(") {
        // Add a new computation context in the stack.
        parenthesisDepth++;
        OperationBuilder firstBuilder = OperationBuilder();
        ComputationContext newContext = ComputationContext(firstBuilder);
        contextStack.push(newContext);
      } else if (token == ")") {
        // ParenthesisNode definition is over.
        if (parenthesisDepth == 0) {
          print("syntax error: Cannot reduce parenthesis depth.");
          return null;
        }
        parenthesisDepth--;
        // Close and reduce current context to a value that can be
        // brought to the rightmost element of the previous context.
        var currentContext = contextStack.pop();
        var reduction = currentContext!.reduceContextToComputation();
        if (reduction == null) {
          print("syntax error found during reduction.");
          return null;
        }
        var valueNode = ValueNode(reduction.getValue());
        contextStack.look()!.lastBuilderAssignTerminal(valueNode);
      } else {
        var value = tryParseValueNode(token);
        if (value == null) {
          // This token might be an operation.
          var operation = tryParseOperationNode(token, parenthesisDepth);
          if (operation == null) {
            print("syntax error: Operation type cannot be identified.");
            return null;
          }
          if (contextStack.look()!.lastBuilderIsReady()) {
            // A new operation builder to be added to this context.
            OperationBuilder newBuilder = OperationBuilder();
            // Link rightmost terminal element of right terminal to leftmost
            // element of next operation.
            newBuilder.setLeft(contextStack.look()!.builders.last.right!);
            // Then add the builder to the new context.
            contextStack.look()!.addBuilderToContext(newBuilder);
          }
          // Assign operator to builder.
          contextStack.look()!.lastBuilderAssignOperator(operation);
        } else {
          // A terminal value has been detected.
          var success = contextStack.look()!.lastBuilderAssignTerminal(value);
          if (!success) {
            // We already have 2 values defined for this operation.
            // We should have received an operator
            print("syntax error: Two consecutive values received.");
            return null; //
          }
        }
      }
    }
    if (parenthesisDepth != 0) {
      print("syntax error: missing parenthesis");
      return null;
    }

    // At this point, we should just have the root context containing the
    // remaining builders.
    var rootComputation = contextStack.pop()!.reduceContextToComputation();
    if (rootComputation == null) {
      return null; // Syntax error: Could not resolve the root computation.
    }
    return Calculator(rootComputation);
  }

}

