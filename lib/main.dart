import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fasy_hotel/view/login.dart';
import 'package:fasy_hotel/view/user/user_dashboard.dart';
import 'package:fasy_hotel/view/admin/admin_dashboard.dart';
import 'package:fasy_hotel/view/SplashScreen.dart'; 


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fasy Hotel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Arial',
      ),
      home: SplashScreen(), 
      getPages: [
        GetPage(name: '/', page: () => ClipLogin19()),
        GetPage(name: '/user_dashboard', page: () => UserDashboard()),
        GetPage(name: '/admin_dashboard', page: () => AdminDashboard()),
      ],
    );
  }
}
