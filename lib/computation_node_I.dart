/// A computation is a tree like structure of values and operations.
/// - The root is the lowest priority operation to execute from left to right.
abstract class ComputationNodeI {
  double getValue();
}

/// A terminal computation is a structure, either a value or a parenthesis, that
/// can be operated with.
abstract class TerminalComputationI extends ComputationNodeI {}

