// register_page.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController idCardController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  Future<void> register() async {
    if (!isValidEmail(emailController.text)) {
      _showErrorDialog('Email must end with @gmail.com');
      return;
    }

    if (idCardController.text.length > 13) {
      _showErrorDialog('ID Card Number must not exceed 13 characters');
      return;
    }

    if (phoneController.text.length != 10) {
      _showErrorDialog('Phone Number must be exactly 10 digits');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2/flutter_moblieapp_api/register.php'),
        body: {
          'username': usernameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'full_name': fullNameController.text,
          'id_card_number': idCardController.text,
          'phone_number': phoneController.text,
          'address': addressController.text,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['message'] == "Registration successful") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        } else {
          _showErrorDialog(responseData['message']);
        }
      } else {
        _showErrorDialog('Registration failed. Please try again.');
      }
    } catch (e) {
      _showErrorDialog('An error occurred. Please try again.');
    }
  }

  bool isValidEmail(String email) {
    return email.endsWith('@gmail.com');
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error', style: TextStyle(color: Colors.red)),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    idCardController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.purple.shade200,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: MediaQuery.of(context).size.height * 0.05,
            ),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTextField(usernameController, 'Username'),
                    const SizedBox(height: 16.0),
                    _buildTextField(emailController, 'Email'),
                    const SizedBox(height: 16.0),
                    _buildTextField(passwordController, 'Password', obscureText: true),
                    const SizedBox(height: 16.0),
                    _buildTextField(fullNameController, 'Full Name'),
                    const SizedBox(height: 16.0),
                    _buildTextField(idCardController, 'ID Card Number'),
                    const SizedBox(height: 16.0),
                    _buildTextField(phoneController, 'Phone Number'),
                    const SizedBox(height: 16.0),
                    _buildTextField(addressController, 'Address'),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: register,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        backgroundColor: Colors.purpleAccent,
                        textStyle: const TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Register'),
                    ),
                    const SizedBox(height: 16.0),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // กลับไปที่หน้าเข้าสู่ระบบ
                      },
                      child: const Text(
                        'Already have an account? Login here',
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.deepPurple),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.deepPurple.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.deepPurple, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
      ),
      keyboardType: label == 'Phone Number' ? TextInputType.phone : TextInputType.text,
      maxLength: label == 'ID Card Number' ? 13 : null,
    );
  }
}
