import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<bool> isFirstLaunchAfterUpdate() async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  final currentVersion = packageInfo.version;

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final String? lastVersion = prefs.getString('lastVersion');

  if (lastVersion == null || lastVersion != currentVersion) {
    await prefs.setString('lastVersion', currentVersion);
    return true;
  }

  return false;
}
