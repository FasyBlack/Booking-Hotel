import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/dashboard_controller.dart';

class AdminDashboard extends StatelessWidget {
  final controller = Get.put(DashboardController());

  final List<Widget> pages = [
    Center(child: Text("Admin Stats")),
    Center(child: Text("Room Management")),
    Center(child: Text("Users")),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: pages[controller.selectedIndex.value],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: controller.selectedIndex.value,
        onTap: controller.changeTabIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Stats"),
          BottomNavigationBarItem(icon: Icon(Icons.meeting_room), label: "Rooms"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Users"),
          BottomNavigationBarItem(icon: Icon(Icons.close), label: "Exit"),
        ],
      ),
    ));
  }
}
