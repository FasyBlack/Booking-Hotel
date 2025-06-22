import 'package:flutter/material.dart';
import 'package:fasy_hotel/view/clip_login_19.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardPage(), // Panggil halaman login yang kamu unduh
    );
  }
}