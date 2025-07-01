import 'package:fasy_hotel/view/user/HomeUserPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fasy_hotel/controller/dashboard_controller.dart';
import 'room_list_page.dart';
import 'booking_history_page.dart';
import 'user_profile_page.dart';
import 'package:fasy_hotel/service/auth_service.dart';
import 'package:fasy_hotel/controller/room_controller.dart';

class UserDashboard extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());
  final AuthService authService = AuthService();
  final RoomController roomController = Get.put(RoomController());


  final List<Widget> pages = [
    HomeUserPage(),
    RoomListPage(),
    BookingHistoryPage(),
    UserProfilePage(),
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
