import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();

  String _registerInfo = '';

  final List<String> _provinces = [
    'กรุงเทพฯ', 'เชียงใหม่', 'ภูเก็ต', 'ขอนแก่น', 'นครราชสีมา', 'ชลบุรี'
  ];

  void _register() {
    if (_nameController.text.isEmpty ||
        _surnameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _provinceController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('กรุณากรอกข้อมูลให้ครบถ้วน'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('ปิด'),
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        _registerInfo =
            'ชื่อ: ${_nameController.text}\n'
            'นามสกุล: ${_surnameController.text}\n'
            'Email: ${_emailController.text}\n'
            'เบอร์โทร: ${_phoneController.text}\n'
            'ที่อยู่: ${_addressController.text}\n'
            'จังหวัด: ${_provinceController.text}';
      });

      _clearFields();
    }
  }

  void _clearFields() {
    _nameController.clear();
    _surnameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _phoneController.clear();
    _addressController.clear();
    _provinceController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  'ลงทะเบียน',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                _buildTextField(_nameController, 'ชื่อ', Icons.person),
                _buildTextField(_surnameController, 'นามสกุล', Icons.person_outline),
                _buildTextField(_emailController, 'Email', Icons.email, inputType: TextInputType.emailAddress),
                _buildTextField(_passwordController, 'Password', Icons.lock, obscureText: true),
                _buildTextField(_phoneController, 'เบอร์โทรศัพท์', Icons.phone, inputType: TextInputType.phone),
                _buildTextField(_addressController, 'ที่อยู่', Icons.home),
                _buildAutocompleteProvince(),
                SizedBox(height: 20),
                _buildButtonRow(),
                SizedBox(height: 20),
                if (_registerInfo.isNotEmpty)
                  Card(
                    elevation: 3,
                    color: Colors.blue[50],
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'ข้อมูลที่ลงทะเบียน:\n$_registerInfo',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool obscureText = false, TextInputType inputType = TextInputType.text}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blueGrey),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget _buildAutocompleteProvince() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return const Iterable<String>.empty();
          }
          return _provinces.where((String province) =>
              province.toLowerCase().contains(textEditingValue.text.toLowerCase()));
        },
        onSelected: (String selection) {
          _provinceController.text = selection;
        },
        fieldViewBuilder: (BuildContext context, TextEditingController textEditingController,
            FocusNode focusNode, VoidCallback onFieldSubmitted) {
          return TextField(
            controller: _provinceController,
            focusNode: focusNode,
            decoration: InputDecoration(
              labelText: 'จังหวัด',
              prefixIcon: Icon(Icons.location_city, color: Colors.blueGrey),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: _register,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          ),
          child: Text('Register', style: TextStyle(fontSize: 16)),
        ),
        ElevatedButton(
          onPressed: _clearFields,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          ),
          child: Text('Cancel', style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}
