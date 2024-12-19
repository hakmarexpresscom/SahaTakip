import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isFirstLoginToday() async {
  final prefs = await SharedPreferences.getInstance();

  String? lastLoginDate = prefs.getString('lastLoginDate');

  DateTime today = DateTime.now();
  String todayString = "${today.year}-${today.month}-${today.day}";

  if (lastLoginDate != todayString) {
    await prefs.setString('lastLoginDate', todayString);
    return true;
  }

  return false;
}