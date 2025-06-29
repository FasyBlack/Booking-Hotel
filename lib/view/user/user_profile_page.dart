import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profil Pengguna")),
      body: Center(child: Text("Informasi profil akan muncul di sini")),
    );
  }
}
