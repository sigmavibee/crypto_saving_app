import 'package:auto_route/auto_route.dart';
import 'package:crypto_saving_app/pages/auth/screen/register_page.dart';
import 'package:crypto_saving_app/styles/text_style.dart';
import 'package:flutter/material.dart';

import '../../../app_router.dart';
import '../../../components/input_widget.dart';
import '../../../services/auth_services.dart';

@RoutePage()
class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService authService = AuthService();
  final ValueNotifier<bool> _obscureTextNotifier = ValueNotifier<bool>(true);

  void _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter both username and password.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    bool success = await authService.login(username, password);
    if (success) {
      print('Login successful. Navigating to main page.');
      context.router.push(const MainRoute());
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
                ValueListenableBuilder<bool>(
                  valueListenable: _obscureTextNotifier,
                  builder: (context, obscureText, child) {
                    return TextFormField(
                      controller: _passwordController,
                      obscureText: obscureText,
                      decoration:
                          customInputDecoration('Masukkan password').copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            _obscureTextNotifier.value = !obscureText;
                          },
                        ),
                      ),
                    );
                  },
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
                                return ResetPassword(press: () {});
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
                            return RegisterPage();
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
      onTap: () {
        context.router.push(
          const RegisterRoute(),
        );
      },
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
