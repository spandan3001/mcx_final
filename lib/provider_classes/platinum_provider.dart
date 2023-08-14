import 'package:mcx_live/services/firestore_services.dart';

class PlatinumProvider {
  static late String point;
  static String token = "000000000";

  static Future<void> getUserFromDB() async {
    await CloudService.platinumDoc.get().then((value) {
      point = value.data()!['point'];
      token = value.data()!['token'];
    });
  }

  static void setPlatinum({
    required String point,
    required String token,
  }) {
    point = point;
    token = token;
  }
}
