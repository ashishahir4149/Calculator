import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fancy Calculator',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  String result = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        input = '';
        result = '';
      } else if (buttonText == '=') {
        try {
          result = _evaluateExpression(input);
        } catch (e) {
          result = 'Error';
        }
      } else if (buttonText == '.') {
        if (!input.contains('.')) {
          input += buttonText;
        }
      } else if (buttonText == '⌫' && input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      } else {
        input += buttonText;
      }
    });
  }

  String _evaluateExpression(String expression) {
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    return eval.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fancy Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Text(
                  input,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  result,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Adjusted button style with custom colors
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButton('.', Colors.green),
              buildButton('0', Colors.green),
              buildButton('=', Colors.green),
              buildButton('⌫', Colors.orange),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButton('1', Colors.green),
              buildButton('2', Colors.green),
              buildButton('3', Colors.green),
              buildButton('+', Colors.green),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButton('4', Colors.green),
              buildButton('5', Colors.green),
              buildButton('6', Colors.green),
              buildButton('-', Colors.green),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButton('7', Colors.green),
              buildButton('8', Colors.green),
              buildButton('9', Colors.green),
              buildButton('*', Colors.green),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButton('(', Colors.green),
              buildButton(')', Colors.green),
              buildButton('!', Colors.green),
              buildButton('/', Colors.green),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButton('%', Colors.green),
              buildButton('x²', Colors.green),
              buildButton('√', Colors.green),
              buildButton('C', Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButton(String buttonText, Color buttonColor) {
    return ElevatedButton(
      onPressed: () {
        _onButtonPressed(buttonText);
      },
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
        padding: EdgeInsets.all(20.0),
        shape: CircleBorder(),
        minimumSize: buttonText == '0' ? Size(70.0, 70.0) : null, // Adjust minimum size for '0'
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: buttonText == '=' ? 20 : 24,
          fontWeight: buttonText == '=' ? FontWeight.bold : FontWeight.normal,
          color: buttonText == '=' ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
