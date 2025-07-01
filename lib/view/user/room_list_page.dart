import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fasy_hotel/controller/room_controller.dart';

class RoomListPage extends StatelessWidget {
  final RoomController controller = Get.find<RoomController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.rooms.isEmpty) {
          return const Center(child: Text("Tidak ada kamar tersedia"));
        }

        return ListView.builder(
          itemCount: controller.rooms.length,
          itemBuilder: (context, index) {
            final room = controller.rooms[index];

            Uint8List? imageBytes;
            try {
              if (room.photo != null && room.photo!.isNotEmpty) {
                imageBytes = base64Decode(room.photo!);
              }
            } catch (e) {
              print("Gagal decode gambar: $e");
            }

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (imageBytes != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.memory(
                        imageBytes,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    Container(
                      height: 200,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      child: const Center(child: Text("No Image")),
                    ),

                  const SizedBox(height: 12),

                  Text(
                    room.roomType.toUpperCase(),
                    style: const TextStyle(fontSize: 12, color: Color.fromARGB(255, 0, 0, 0)),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    "Luxury On Your Doorstep",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  Text("Harga: Rp ${room.roomPrice}"),

                  const SizedBox(height: 12),

                  Row(
                    children: const [
                      Icon(Icons.check, color: Color.fromARGB(255, 233, 134, 98)),
                      SizedBox(width: 6),
                      Text("AC, Wifi, Breakfast"),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      // Expanded(
                      //   child: OutlinedButton(
                      //     onPressed: () {},
                      //     child: const Text("FIND OUT MORE"),
                      //   ),
                      // ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 13, 150, 255)),
                              
                          onPressed: () {},
                          child: const Text("BOOK NOW",
                          style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ],
                  ),

                  const Divider(height: 32),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
