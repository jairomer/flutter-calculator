import 'package:flutter/material.dart';
import 'button_controller.dart';
import 'symbol.dart';
import 'globals.dart' as globals;

void main() {
  CalculatorController appController = CalculatorController();
  globals.log.d("Application started");
  runApp(CalculatorAppView(appController));
}

class CalculatorAppView extends StatelessWidget {
  final CalculatorController controller;
  const CalculatorAppView(this.controller, {super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: RootPage(controller),
    );
  }
}

class RootPage extends StatefulWidget {
  final CalculatorController controller;

  const RootPage(this.controller, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _RootPageState();
}

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
  get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    const buttonMargin = 5.0;
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Calculator')),
      body: Column(children: [
        buildConsole(),
        const Divider(
          color: Colors.black,
        ),
        Expanded(child: Container(height: 1)),
        buildRadianDegreeSwitch(),
        const Divider(
          color: Colors.black,
        ),
        buildKeypad(buttonMargin)
      ]),
    );
  }

  Row buildRadianDegreeSwitch() {
    return Row(
      children: [
        Expanded(
            child: TextButton(
                onPressed: () {
                  setState(() {
                    controller.isDegree = !controller.isDegree;
                  });
                },
                child: Text(
                  controller.isDegree ? "Degrees" : "Radians",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ))),
      ],
    );
  }

  Row buildConsole() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(15.0),
            child: Text(
              controller.content,
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
        child: Column(
          children: [
            buildKeyPadRow(buttonMargin, Symbols.inv, Symbols.tangent,
                Symbols.cosine, Symbols.sine),
            buildKeyPadRow(
                buttonMargin, Symbols.e, Symbols.log, Symbols.ln, Symbols.fact),
            buildKeyPadRow(buttonMargin, Symbols.sqrt, Symbols.exp, Symbols.pow,
                Symbols.ans),
            buildKeyPadRow(buttonMargin, Symbols.startParenthesis,
                Symbols.endParenthesis, Symbols.percent, Symbols.ac),
            buildKeyPadRow(buttonMargin, "7", "8", "9", Symbols.divOp),
            buildKeyPadRow(buttonMargin, "4", "5", "6", Symbols.mulOp),
            buildKeyPadRow(buttonMargin, "1", "2", "3", Symbols.subOp),
            buildKeyPadRow(
                buttonMargin, "0", Symbols.point, Symbols.eqOp, Symbols.addOp),
          ],
        ));
  }

  Row buildKeyPadRow(double buttonMargin, String first, String second,
      String third, String fourth) {
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
    } else if (Symbols.isNumber(character) || character == ".") {
      style = ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey,
      );
    } else if (character == Symbols.ac) {
      style = ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
      );
    } else if (character == Symbols.ac) {
      style = ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
      );
    }
    return Expanded(
        child: Container(
      margin: EdgeInsets.all(buttonMargin),
      child: ElevatedButton(
          style: style,
          onPressed: () {
            setState(() {
              controller.onCalculatorButtonPress(character);
            });
          },
          child: Text(character)),
    ));
  }
}
