import 'package:flutter/material.dart';

import 'pages/auth/screen/auth_page.dart';
import 'pages/main_page.dart';
import 'pages/onboarding_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Presale Crypto App',
      routes: {
        OnBoardingPage.nameRoute: (context) => OnBoardingPage(),
        AuthenticationPage.nameRoute: (context) => AuthenticationPage(),
        MainPage.nameRoute: (context) => MainPage(),
      },
    );
  }
}
