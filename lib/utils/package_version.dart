import 'package:package_info_plus/package_info_plus.dart';
import 'package:tms/state_management.dart';

Future<void> packageVersion() async {
  final info = await PackageInfo.fromPlatform();
  Store.version.value = info.version;
}
