import 'computation_node_I.dart';

/// This abstraction represents the kind of operation to execute from left to
/// right.
abstract class OperationI {
  int priority = 0;
  double apply(TerminalComputationI left, TerminalComputationI right);
  void setPriority(int priority) {
    this.priority = priority;
  }

  /// We need to establish an order relationship between operations in
  /// order to sort them;
  bool operator>=(OperationI other) {
    return priority >= other.priority;
  }

  bool operator<=(OperationI other) {
    return priority <= other.priority;
  }
}

abstract class MathFunctionI {
  double apply(double value);
}

class NotANumberException implements Exception {}

/// Implements sum from first (left) to last.
class SumOperation extends OperationI {
  @override
  double apply(TerminalComputationI left, TerminalComputationI right) {
    double leftValue = left.getValue();
    double rightValue = right.getValue();
    return leftValue + rightValue;
  }
}

/// Implements subtraction from first (left) to last.
class SubsOperation extends OperationI {
  @override
  double apply(TerminalComputationI left, TerminalComputationI right) {
    double leftValue = left.getValue();
    double rightValue = right.getValue();
    return leftValue - rightValue;
  }
}

/// Implements multiplication from first to last.
class MultOperation extends OperationI {
  @override
  double apply(TerminalComputationI left, TerminalComputationI right) {
    double leftValue = left.getValue();
    double rightValue = right.getValue();
    return leftValue * rightValue;
  }
}

/// Implements division from first to last.
class DivOperation extends OperationI {
  @override
  double apply(TerminalComputationI left, TerminalComputationI right) {
    double leftValue = left.getValue();
    double rightValue = right.getValue();
    if (rightValue == 0) {
      // Cannot divide by zero.
      throw NotANumberException;
    }
    return leftValue / rightValue;
  }
}
