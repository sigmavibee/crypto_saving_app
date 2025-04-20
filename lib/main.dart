import 'package:flutter/material.dart';

import 'app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter(); // Tambahkan ini

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Presale Crypto App',
      routerDelegate: _appRouter.delegate(),
      routeInformationParser:
          _appRouter.defaultRouteParser(), // Fixed method call
    );
  }
}
