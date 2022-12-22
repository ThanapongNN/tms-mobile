import 'package:get_storage/get_storage.dart';

//เก็บข้อมูลลงใน Local
class LocalStorage {
  //HOST
  static Future<void> writeHost(String host) async {
    await GetStorage().write('host', host);
  }

  static String readHost() {
    String host = GetStorage().read('host') ?? 'https://c0ff-171-96-39-168.ap.ngrok.io';
    return host;
  }
}
