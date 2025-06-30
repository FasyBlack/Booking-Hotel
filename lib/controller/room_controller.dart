import 'package:get/get.dart';
import '../model/room_model.dart';
import '../service/room_service.dart';

class RoomController extends GetxController {
  var rooms = <Room>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchRooms();
    super.onInit();
  }

  void fetchRooms() async {
    try {
      isLoading(true);
      var fetchedRooms = await RoomService().getRooms();
      rooms.value = fetchedRooms;
    } catch (e) {
      print('Gagal fetch room: $e');
    } finally {
      isLoading(false);
    }
  }
}
