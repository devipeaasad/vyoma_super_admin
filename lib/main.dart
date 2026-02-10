import 'package:flutter/material.dart';
import 'pages/admin_login_page.dart';
import 'pages/admin_home_page.dart';

void main() {
  runApp(const AdminApp());
}

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vyoma Super Admin',

      initialRoute: '/login',

      routes: {
        '/login': (context) => const AdminLoginPage(),
        '/adminHome': (context) => const AdminHomePage(),
      },
    );
  }
}
