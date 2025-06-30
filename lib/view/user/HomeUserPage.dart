import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../service/user_service.dart';
import '../../../service/room_service.dart';


class HomeUserPage extends StatefulWidget {
  const HomeUserPage({super.key});

  @override
  _HomeUserPageState createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage> {
  String fullName = 'User';
  List<Map<String, dynamic>> rooms = [];
  bool isLoading = true;

  final List<String> images = [
    'assets/1.jpg',
    'assets/2.jpeg',
    'assets/3.jpg',
    'assets/4.jpeg',
  ];

  @override
  void initState() {
    super.initState();
    loadUserName();
    loadRooms();
  }

  void loadUserName() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('email');

      if (email != null) {
        final userData = await UserService().getUserByEmail(email);
        setState(() {
          fullName = '${userData['firstName']} ${userData['lastName']}';
        });
      }
    } catch (e) {
      print("❌ Gagal ambil nama user: $e");
    }
  }

  void loadRooms() async {
    try {
      final data = await RoomService().getRooms();
      if (mounted) {
        setState(() {
          rooms = List<Map<String, dynamic>>.from(data);
          isLoading = false;
        });
      }
    } catch (e) {
      print("❌ Gagal fetch rooms: $e");
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 246, 246),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Selamat Datang,\n$fullName',
                        style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Image.asset('assets/logo.png', width: 40),
                    ],
                  ),
                ),

                // Slider
                ImageCarousel(images: images),
                const SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'Temukan kenyamanan menginap terbaik hanya di Fasy Hotel. Silakan pilih kamar untuk melanjutkan.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  ),
                ),

                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Text(
                    'Recomended',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),

                SizedBox(
                  height: 230,
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : rooms.isEmpty
                          ? const Center(child: Text('Tidak ada kamar tersedia'))
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: rooms.length,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              itemBuilder: (context, index) {
                                final room = rooms[index];
                                try {
                                  final imageBase64 = room['photo'];
                                  final imageBytes = base64Decode(imageBase64);
                                  return Container(
                                    width: 220,
                                    margin: const EdgeInsets.only(right: 16),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 4,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: const BorderRadius.vertical(
                                              top: Radius.circular(12)),
                                            child: Image.memory(
                                              imageBytes,
                                              height: 120,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              room['roomType'] ?? 'Tipe Tidak Diketahui',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Text(
                                              'Harga: Rp ${room['roomPrice'] ?? '-'}',
                                              style: const TextStyle(fontSize: 14, color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } catch (e) {
                                  return const Text("❌ Gagal render gambar kamar.");
                                }
                              },
                            ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageCarousel extends StatefulWidget {
  final List<String> images;
  const ImageCarousel({super.key, required this.images});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    autoSlide();
  }

  void autoSlide() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_pageController.hasClients) {
        int nextPage = (currentPage + 1) % widget.images.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        setState(() {
          currentPage = nextPage;
        });
        autoSlide(); // call again to repeat
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(widget.images[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.images.length, (index) {
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
      ],
    );
  }
}

