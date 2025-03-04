import 'package:flutter/material.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _majorController = TextEditingController();
  final _facultyController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  String _registeredData = '';

  void _register() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _registeredData = 
          'ข้อมูลนักศึกษา:\n'
          'รหัสนักศึกษา: ${_idController.text}\n'
          'ชื่อ: ${_nameController.text}\n'
          'นามสกุล: ${_surnameController.text}\n'
          'สาขา: ${_majorController.text}\n'
          'คณะ: ${_facultyController.text}\n'
          'เบอร์โทรศัพท์: ${_phoneController.text}\n'
          'อีเมล: ${_emailController.text}';
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text('เกิดข้อผิดพลาด', style: TextStyle(color: Colors.red)),
          content: const Text('กรุณากรอกข้อมูลให้ครบถ้วน'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('ปิด', style: TextStyle(color: Colors.deepPurple)),
            ),
          ],
        ),
      );
    }
  }

  void _cancel() {
    setState(() {
      _idController.clear();
      _nameController.clear();
      _surnameController.clear();
      _majorController.clear();
      _facultyController.clear();
      _phoneController.clear();
      _emailController.clear();
      _registeredData = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('65064435 สมภพ เอี่ยมสมบัติ'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildTextField(_idController, 'รหัสนักศึกษา'),
                      _buildTextField(_nameController, 'ชื่อ'),
                      _buildTextField(_surnameController, 'นามสกุล'),
                      _buildTextField(_majorController, 'สาขา'),
                      _buildTextField(_facultyController, 'คณะ'),
                      _buildTextField(_phoneController, 'เบอร์โทรศัพท์', TextInputType.phone),
                      _buildTextField(_emailController, 'อีเมล', TextInputType.emailAddress),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: _register,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Register'),
                          ),
                          ElevatedButton(
                            onPressed: _cancel,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[400],
                              foregroundColor: Colors.black,
                            ),
                            child: const Text('Cancel'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      if (_registeredData.isNotEmpty)
                        Card(
                          color: Colors.deepPurple[50],
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              _registeredData,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, [TextInputType? keyboardType]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: Colors.white,
        ),
        keyboardType: keyboardType,
        validator: (value) => value!.isEmpty ? 'Required' : null,
      ),
    );
  }
}