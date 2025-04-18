import 'package:crypto_saving_app/styles/colors.dart';
import 'package:crypto_saving_app/styles/text_style.dart';
import 'package:flutter/material.dart';

import '../../../components/input_widget.dart';
import '../../../services/auth_services.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});
  static const nameRoute = '/auth';

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService authService = AuthService();

  void _login() async {
    print('Attempting to log in with username: ${_usernameController.text}');
    print('Attempting to log in with username: ${_passwordController.text}');
    bool success = await authService.login(
      _usernameController.text,
      _passwordController.text,
    );
    if (success) {
      print('Login successful. Navigating to main page.');
      Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
    } else {
      print('Login failed. Showing error message.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed. Please check your credentials.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Wrap with Scaffold
      body: Form(
        child: Padding(
          padding: const EdgeInsets.only(right: 12, left: 12, top: 200),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        'Login',
                        style: kHeading5,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Crypto Super App',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              InputLayout(
                'Username',
                TextFormField(
                  controller: _usernameController,
                  decoration: customInputDecoration('Masukkan username anda'),
                ),
              ),
              InputLayout(
                'Password',
                TextFormField(
                  controller: _passwordController,
                  decoration: customInputDecoration('Masukkan password'),
                ),
              ),
              const SizedBox(height: 5),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ResetPassword(
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const ResetPasswordScreen();
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: _login,
                    child: Text(
                      "Login".toUpperCase(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  AlreadyHaveAnAccountCheck(
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const SignUpScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => press(),
      child: Text(
        "Don't have an account? Sign Up",
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
    );
  }
}

class ResetPassword extends StatelessWidget {
  final Function press;
  const ResetPassword({
    Key? key,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => press(),
      child: Text(
        "Lupa password ?",
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Center(
        child: Text("Sign Up Screen"),
      ),
    );
  }
}

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lupa Password"),
      ),
      body: Center(
        child: Text("Reset Password Screen"),
      ),
    );
  }
}
