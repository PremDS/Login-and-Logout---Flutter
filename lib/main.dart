import 'package:flutter/material.dart';
import 'package:login_system/pages/login_page.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Login with JWT',
      debugShowCheckedModeBanner: false,
      theme:ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.redAccent,
        accentColor: Colors.cyan[600]
      ),
      home: LoginPage(),
    );
  }
}
