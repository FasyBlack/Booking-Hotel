import 'package:flutter/material.dart';
import 'package:fasy_hotel/view/login.dart';
import 'package:fasy_hotel/view/dashboard.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aston Hotel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Arial',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ClipLogin19(),     // Halaman Login
        '/dashboard': (context) => const DashboardPage(), // ganti nama class jika perlu
      },
    );
  }
}