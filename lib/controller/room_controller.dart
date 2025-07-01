import 'package:get/get.dart';
import '../model/room_model.dart';
import '../service/room_service.dart';

class RoomController extends GetxController {
  var isLoading = true.obs;
  var rooms = <Room>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRooms();
  }

  void fetchRooms() async {
    try {
      isLoading(true);
      final data = await RoomService().getRooms();
      rooms.assignAll(data);
    } catch (e) {
      print("Gagal ambil data kamar: $e");
    } finally {
      isLoading(false);
    }
  }
}
