import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _expression = "";
  String _result = "0";

  void _onPressed(String value) {
    setState(() {
      if (value == "C") {
        _expression = "";
        _result = "0";
      } else if (value == "=") {
        try {
          _result = _evaluateExpression(_expression).toString();
        } catch (e) {
          _result = "Error";
        }
      } else {
        _expression += value;
      }
    });
  }

  double _evaluateExpression(String exp) {
    try {
      List<String> tokens = _tokenize(exp);
      return _calculate(tokens);
    } catch (e) {
      return double.nan;
    }
  }

  List<String> _tokenize(String exp) {
    RegExp regExp = RegExp(r'(\d+\.?\d*|\+|\-|\*|\/)');
    return regExp.allMatches(exp).map((m) => m.group(0)!).toList();
  }

  double _calculate(List<String> tokens) {
    List<double> numbers = [];
    List<String> operators = [];

    for (var token in tokens) {
      if (RegExp(r'^\d+\.?\d*$').hasMatch(token)) {
        numbers.add(double.parse(token));
      } else {
        while (operators.isNotEmpty &&
            _precedence(operators.last) >= _precedence(token)) {
          _compute(numbers, operators.removeLast());
        }
        operators.add(token);
      }
    }

    while (operators.isNotEmpty) {
      _compute(numbers, operators.removeLast());
    }

    return numbers.isNotEmpty ? numbers.first : 0.0;
  }

  void _compute(List<double> numbers, String operator) {
    if (numbers.length < 2) return;

    double b = numbers.removeLast();
    double a = numbers.removeLast();
    double result = 0;

    switch (operator) {
      case '+':
        result = a + b;
        break;
      case '-':
        result = a - b;
        break;
      case '*':
        result = a * b;
        break;
      case '/':
        result = (b != 0) ? a / b : double.nan;
        break;
    }

    numbers.add(result);
  }

  int _precedence(String operator) {
    if (operator == '+' || operator == '-') return 1;
    if (operator == '*' || operator == '/') return 2;
    return 0;
  }

  Widget _buildButton(String text, {Color? color}) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _onPressed(text),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(20),
          backgroundColor: color ?? Colors.blueGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('เครื่องคิดเลข')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _expression,
                    style: TextStyle(fontSize: 32, color: Colors.grey[700]),
                  ),
                  Text(
                    _result,
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Divider(thickness: 1),
          Column(
            children: [
              _buildRow(["7", "8", "9", "/"], Colors.orange),
              _buildRow(["4", "5", "6", "*"], Colors.orange),
              _buildRow(["1", "2", "3", "-"], Colors.orange),
              _buildRow(["C", "0", "=", "+"], Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRow(List<String> values, Color opColor) {
    return Row(
      children: values.map((text) {
        return _buildButton(
          text,
          color: ["+", "-", "*", "/"].contains(text) ? opColor : null,
        );
      }).toList(),
    );
  }
}
