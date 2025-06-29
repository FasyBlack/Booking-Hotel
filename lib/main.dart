import 'package:flutter/material.dart';
import 'package:fasy_hotel/view/login.dart';
import 'package:fasy_hotel/view/user/user_dashboard.dart';
import 'package:fasy_hotel/view/admin_dashboard.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aston Hotel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Arial',
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const ClipLogin19()),
        GetPage(name: '/user_dashboard', page: () => UserDashboard()),
        GetPage(name: '/admin_dashboard', page: () => AdminDashboard()),
      ],
    );
  }
}
