import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../service/user_service.dart';

class RoomListPage extends StatefulWidget {
  const RoomListPage({super.key});

  @override
  State<RoomListPage> createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> {
  String userName = "Pengguna";

  @override
  void initState() {
    super.initState();
    loadUserName();
  }

  void loadUserName() async {
    // Panggil UserService untuk ambil nama user dari token/login
    final name = await UserService().getUserName();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Atas: Nama + Logo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Halo, $userName",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Image.asset(
                  'assets/aston.jpg', // pastikan kamu punya gambar ini
                  height: 40,
                ),
              ],
            ),
          ),

          
        ],
      ),
    );
  }
}
