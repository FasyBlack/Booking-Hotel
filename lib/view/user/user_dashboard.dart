import 'package:fasy_hotel/view/user/HomeUserPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/dashboard_controller.dart';

import 'room_list_page.dart';
import 'booking_history_page.dart';
import 'user_profile_page.dart';

class UserDashboard extends StatelessWidget {
  final controller = Get.put(DashboardController());

  final List<Widget> pages = [
     HomeUserPage(),
    const RoomListPage(),
    const BookingHistoryPage(),
    const UserProfilePage(),
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
            onTap: (index) {
              if (index == 3) {
                // Logout
                Get.offAllNamed('/');
              } else {
                controller.changeTabIndex(index);
              }
            },
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.hotel),
                label: "Rooms",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: "Booking",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.logout),
                label: "Exit",
              ),
            ],
          ),
        ));
  }
}
