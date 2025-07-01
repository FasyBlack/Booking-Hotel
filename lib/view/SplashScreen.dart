import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fasy_hotel/view/login.dart';
import 'package:fasy_hotel/view/user/user_dashboard.dart';
import 'package:fasy_hotel/view/admin/admin_dashboard.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    await Future.delayed(const Duration(seconds: 2)); 
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final role = prefs.getString('role'); 

    if (token != null && role != null) {
      if (role == 'ROLE_ADMIN') {
        Get.offAll(() => AdminDashboard());
      } else if (role == 'ROLE_USER') {
        Get.offAll(() => UserDashboard()); 
      } else {
        Get.offAll(() => ClipLogin19());
      }
    } else {
      Get.offAll(() => ClipLogin19());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
