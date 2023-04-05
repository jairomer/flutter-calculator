import 'package:flutter/cupertino.dart';

import 'computation_node_I.dart';
import 'operations.dart';

/// A value node in a computation is defined as an entity which:
/// - Contains a value.
/// - Does not have descendants
/// - Its parent is the operation it is involved in.
class ValueNode implements TerminalComputationI {
  final double value;
  ValueNode(this.value);
  @override
  double getValue() {
    return value;
  }
}

/// An Operation Node in a computation is defined as an entity which:
/// - Always contains at least one descendant.
/// - Is either a root or a bifurcation in the Computation graph.
/// - Applies an operation to a list of descendants.
class OperationNode implements ComputationNodeI {
  TerminalComputationI left;
  TerminalComputationI right;
  final OperationI operation;
  OperationNode(this.left, this.operation, this.right);
  @override
  double getValue() {
    return operation.apply(left, right);
  }
}


class OperationBuilder {
  TerminalComputationI? left;
  TerminalComputationI? right;
  OperationI? operation;
  void setLeft(TerminalComputationI t) {
    left = t;
  }
  void setRight(TerminalComputationI t) {
    right = t;
  }
  void setOperation(OperationI op) {
    operation = op;
  }

  bool assignTerminal(TerminalComputationI t) {
    if (left == null) {
      left = t;
      return true;
    }
    if (right == null) {
      right = t;
      return true;
    }
    return false;
  }

  bool isReady() {
    return left != null && right != null && operation != null;
  }

  OperationNode? getOperationNode() {
    if (!isReady()) {
      return null;
    }
    return OperationNode(left!, operation!, right!);
  }
}

class ComputationContext {
  late List<OperationBuilder> builders;
  ComputationContext(OperationBuilder first) {
    builders = [];
    builders.add(first);
  }
  void addBuilderToContext(OperationBuilder builder) {
    builders.add(builder);
  }
  ComputationNodeI? reduceContextToComputation() {
    List<OperationNode> operations = [];
    for (var builder in builders) {
      var operationNode = builder.getOperationNode();
      if (operationNode == null) {
        return null; // syntax error: Cannot build operation from this context.
      }
      operations.add(operationNode!);
    }
    operations.sort();
    // This needs some testing, but the lowest priority operation will contain
    // the one of larger priority.
    return operations.first;
  }

  bool lastBuilderIsReady() {
    return builders.last.isReady();
  }

  bool lastBuilderAssignTerminal(TerminalComputationI t) {
    return builders.last.assignTerminal(t);
  }

  void lastBuilderAssignOperator(OperationI op) {
    return builders.last.setOperation(op);
  }
}

class FunctionNode implements TerminalComputationI {
  late ComputationNodeI content;
  final MathFunctionI function;
  FunctionNode(this.function);

  @override
  double getValue() {
    return function.apply(content.getValue());
  }
}

/// A parenthesis node is a container for either a value or other computations.
class ParenthesisNode implements TerminalComputationI {
  ComputationNodeI content;
  ParenthesisNode(this.content);
  @override
  double getValue() {
     return content.getValue();
  }
}

/// Wrapper for the syntax tree.
class Calculator {
  ComputationNodeI rootComputation;
  Calculator(this.rootComputation);
  double compute() {
    return rootComputation.getValue();
  }
}