import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _RootPageState();
}
/* TODO: Extend widget for several screen sizes.
   * - Mobile
   * - Large
   */

// TODO: Additional features:
//  - Save current calculator state.
//  - Retrieve state.

// Textview
//  - Static, only shows the results from the pad.

// Operations
//  - Sum, Multiplication, Subtraction, Division
//  - Add Parenthesis
//  - Apply percentage to current number.
//  - AC or 'Clear' Button
//  - Reference to previous Answer
//  - EXP button, which is 10^X
//  - Logarithm
//  - Logarithm in base e
//  - Exponential of an integer.
//  - RAD/DEG shift between angle modes.
//    * This implies a change on state, we need to indicate the user if //      the current operations are executed on radians or degrees.
//  - Inverse trigonometric function
//    * Can only be applied to trigonometric functions.
//  - Trigonometric functions.
//    * sin
//    * cos
//    * tan
//  - square root
//  - Exponentiation of a given base.
//  - Equality operator
//    * Executes the operation from left to right.
//    * Considers the priority of the operations.

// Constants
//  - pi
//  - e
//  - Numbers from 0 to 9
//  - Decimal signaling point
//
class _RootPageState extends State<RootPage> {
  String content = "";
  String previousAnswer = "";
  String previousCharacter = "";
  bool isDegree = true;
  final sqrt = "√";

  bool isNumber(String value) {
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

  bool isAllowedRepetition(String value) {
    return
        isNumber(value) ||
        value == "(" ||
        value == ")";
  }

  bool isFunction(String value) {
    return value == "Inv" ||
        value == "tan" ||
        value == "cos" ||
        value == "sin" ||
        value == "log" ||
        value == sqrt ||
        value == "ln";
  }

  bool isArithmeticOperation(String value) {
    return
        value == "/" ||
        value == "x" ||
        value == "-" ||
        value == "+";
  }

  void addTextProtocol(String value) {
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
    } else if (isFunction(value)) {
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

  @override
  Widget build(BuildContext context) {
    const buttonMargin = 5.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Calculator')
      ),
      body: Column(
        children: [
          buildConsole(),
          const Divider(
            color: Colors.black,
          ),
          Expanded(
              child: Container(height: 1)
          ),
          buildRadianDegreeSwitch(),
          const Divider(
            color: Colors.black,
          ),
          buildKeypad(buttonMargin)
        ]
      ),
    );
  }

  Row buildRadianDegreeSwitch() {
    return Row(
          children: [
            Expanded(
                child: TextButton(
                    onPressed: (){
                      setState(() {
                        isDegree = !isDegree;
                      });
                    },
                    child: Text(
                        isDegree ? "Degrees" : "Radians",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),)
                )
            ),
          ],
        );
  }

  Row buildConsole() {
    return Row(
          children: [
            Container(
              margin: const EdgeInsets.all(15.0),
              child: Expanded(
                child: Text(
                    content,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                      fontSize: 42,
                    ),
                ),
              ),
            ),
          ],
        );
  }

  Container buildKeypad(double buttonMargin) {
    return Container(
          margin: const EdgeInsets.all(2.0),
          child: Column (
            children: [
              buildKeyPadRow(buttonMargin, "Inv", "tan", "cos", "sin"),
              buildKeyPadRow(buttonMargin, "e", "log", "ln", "x!"),
              buildKeyPadRow(buttonMargin, "√", "Exp", "^", "Ans"),
              buildKeyPadRow(buttonMargin, "(", ")", "%", "AC"),
              buildKeyPadRow(buttonMargin, "7", "8", "9", "/"),
              buildKeyPadRow(buttonMargin, "4", "5", "6", "x"),
              buildKeyPadRow(buttonMargin, "1", "2", "3", "-"),
              buildKeyPadRow(buttonMargin, "0", ".", "=", "+"),
            ],
          )
    );
  }

  Row buildKeyPadRow(double buttonMargin, String first, String second, String third, String fourth) {
    return Row(
            children: [
              buildButton(buttonMargin, first),
              buildButton(buttonMargin, second),
              buildButton(buttonMargin, third),
              buildButton(buttonMargin, fourth),
            ],
          );
  }

  Expanded buildButton(double buttonMargin, String character) {
    var style = ElevatedButton.styleFrom(
      backgroundColor: Colors.blueAccent,
    );
    if (character == "=") {
      style = ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
      );
    } else if (isNumber(character) || character == ".") {
      style = ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey,
      );
    } else if (character == "AC") {
      style = ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
      );
    } else if (character == "Ans") {
      style = ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
      );
    }
    return Expanded(
                child: Container(
                  margin: EdgeInsets.all(buttonMargin),
                  child: ElevatedButton(
                      style: style,
                      onPressed: (){
                        setState(() {
                          addTextProtocol(character);
                        });
                      },
                      child: Text(character)
                  ),
                )
            );
  }
}
