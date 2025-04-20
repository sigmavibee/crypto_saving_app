import 'package:crypto_saving_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/annotations.dart';

import '../../../components/input_widget.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService authService = AuthService();

  void _register() async {
    print('Attempting to log in with username: ${_nameController.text}');
    print('Attempting to log in with username: ${_emailController.text}');
    print('Attempting to log in with username: ${_usernameController.text}');
    print('Attempting to log in with username: ${_passwordController.text}');
    bool success = await AuthService().register(
      _usernameController.text,
      _emailController.text,
      _nameController.text,
      _passwordController.text,
    );

    if (success) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Registration Successful'),
            content: Text('You have successfully registered.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Center(child: Text('OK')),
              ),
            ],
          );
        },
      );
      Navigator.pushNamed(context, '/login');
    } else {
      // Show error message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Registration Failed'),
            content: Text('Error occurred during registration.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Center(child: Text('OK')),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InputLayout(
                    'Username',
                    TextFormField(
                      controller: _usernameController,
                      decoration:
                          customInputDecoration('Masukkan username anda'),
                    ),
                  ),
                  SizedBox(height: 8),
                  InputLayout(
                    'Nama Lengkap',
                    TextFormField(
                      controller: _nameController,
                      decoration:
                          customInputDecoration('Masukkan nama lengkap anda'),
                    ),
                  ),
                  SizedBox(height: 8),
                  InputLayout(
                    'Email',
                    TextFormField(
                      controller: _emailController,
                      decoration: customInputDecoration('Masukkan email anda'),
                    ),
                  ),
                  SizedBox(height: 8),
                  InputLayout(
                    'Password',
                    TextFormField(
                      controller: _passwordController,
                      decoration:
                          customInputDecoration('Masukkan password anda'),
                      obscureText: true,
                    ),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      _register();
                    },
                    child: Text(
                      "Register".toUpperCase(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
