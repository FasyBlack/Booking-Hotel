import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../service/user_service.dart'; // pastikan path sesuai

class HomeUserPage extends StatefulWidget {
  const HomeUserPage({super.key});

  @override
  _HomeUserPageState createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage> {
  String fullName = 'User';
  final PageController _pageController = PageController();
  int currentPage = 0;

  final List<String> images = [
    'assets/aston.jpg',
    'assets/aston.jpg',
    'assets/aston.jpg',
    'assets/aston.jpg',
  ];

  @override
  void initState() {
    super.initState();
    loadUserName();
    autoSlide();
  }

  void loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');

    if (email != null) {
      try {
        final userData = await UserService().getUserByEmail(email);
        setState(() {
          fullName = '${userData['firstName']} ${userData['lastName']}';
        });
      } catch (e) {
        print("Gagal ambil nama user: $e");
      }
    }
  }

  void autoSlide() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_pageController.hasClients) {
        int nextPage = (currentPage + 1) % images.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        setState(() {
          currentPage = nextPage;
        });
        autoSlide();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header dengan nama dan logo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Selamat Datang,\n$fullName',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Image.asset('assets/aston.jpg', width: 40), // logo hotel
                ],
              ),
            ),

            // Slider
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage(images[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Indikator Slide
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(images.length, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentPage == index ? 12 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: currentPage == index ? Colors.blue : Colors.grey[400],
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),

            // Tambahan: deskripsi atau tombol
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Temukan kenyamanan menginap terbaik hanya di LakeSide Hotel. Silakan pilih kamar untuk melanjutkan.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[800]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
