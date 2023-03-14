import 'package:shared_preferences/shared_preferences.dart';

class UserSettingsRepo {
  static String keyIsShowOnboard = 'isShowOnboard';

  Future<bool> getIsShowOnboard() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyIsShowOnboard) ?? false;
  }

  Future setIsShowOnboard(bool show) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(keyIsShowOnboard, show);
  }
}
