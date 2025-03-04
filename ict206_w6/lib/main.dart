import 'package:flutter/material.dart';
import 'package:ict206_w6/function_bmi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BMICalculatorPage(),
    );
  }
}

class BMICalculatorPage extends StatefulWidget {
  @override
  _BMICalculatorPageState createState() => _BMICalculatorPageState();
}

class _BMICalculatorPageState extends State<BMICalculatorPage> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  String? _bmiResult;
  String? _bmiTextResult;
  String? _errorMessage;

  void _calculateBMI() {
    double? weight = double.tryParse(_weightController.text);
    double? height = double.tryParse(_heightController.text);

    if (weight == null || height == null || weight <= 0 || height <= 0) {
      setState(() {
        _bmiResult = null;
        _bmiTextResult = null;
        _errorMessage = 'กรุณากรอกค่าน้ำหนักและส่วนสูงให้ถูกต้อง';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('กรุณากรอกข้อมูลที่ถูกต้อง')),
      );
    } else {
      var res = function_bmi(weight, height);

      double bmi = res[0];
      String message = res[1];

      setState(() {
        _bmiResult = 'ค่า BMI ของคุณคือ: ${bmi.toStringAsFixed(2)}';
        _bmiTextResult = 'ผลลัพธ์ : ${message}';
        _errorMessage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'น้ำหนัก (กิโลกรัม)',
                errorText: _errorMessage,
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'ส่วนสูง (เมตร)',
                errorText: _errorMessage,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _calculateBMI,
              child: Text('คำนวณ BMI'),
            ),
            SizedBox(height: 20.0),
            if (_bmiResult != null)
              Text(
                _bmiResult!,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            if (_bmiTextResult != null)
              Text(
                _bmiTextResult!,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }
}
