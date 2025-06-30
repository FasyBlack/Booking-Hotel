import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/dashboard_controller.dart';
import 'package:fasy_hotel/service/auth_service.dart';
import 'package:fasy_hotel/view/admin/AddRoomPage.dart';

class AdminDashboard extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());
  final AuthService authService = AuthService();

  final List<Widget> pages = [
    Center(child: Text("Admin Stats")),
    AddRoomPage(),
    Center(child: Text("Users")),
    Center(child: Text("Logout")),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.selectedIndex.value,
              children: pages,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: (index) async {
              if (index == 3) {
                // Logout
                await authService.logout();
                Get.offAllNamed('/');
              } else {
                controller.changeTabIndex(index);
              }
            },
            selectedItemColor: const Color.fromARGB(255, 9, 116, 204),
            unselectedItemColor: const Color.fromARGB(255, 112, 111, 111),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart), label: "Stats"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.meeting_room), label: "Rooms"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people), label: "Users"),
              BottomNavigationBarItem(icon: Icon(Icons.close), label: "Exit"),
            ],
          ),
        ));
  }
}
