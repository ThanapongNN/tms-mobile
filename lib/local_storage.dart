import 'package:get_storage/get_storage.dart';

//เก็บข้อมูลลงใน Local
class LocalStorage {
  //HOST
  static Future<void> writeHost(String host) async {
    await GetStorage().write('host', host);
  }

  static String readHost() {
    String host = GetStorage().read('host') ?? 'https://c246-171-96-154-114.ap.ngrok.io';
    return host;
  }
}
