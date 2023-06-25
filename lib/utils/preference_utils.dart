import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static SharedPreferences? preferences;

  static Future<bool> initPreference() async {
    preferences ??= await SharedPreferences.getInstance();
    return true;
  }

  /// set values
  static void setAutoCopyToClipBoardValue(bool value) {
    preferences?.setBool("autoCopyToClipBoard", value);
  }

  static void setScanControl(String value) {
    preferences?.setString("scanControl", value);
  }

  static void setAddScanHistoryValue(bool value) {
    preferences?.setBool("addScanHistory", value);
  }

  static void setFocus(String value) {
    preferences?.setString("focus", value);
  }

  /// get values

  static bool getAutoCopyToClipBoardValue([bool? value]) {
    return preferences?.getBool("autoCopyToClipBoard") ?? value ?? true;
  }

  static String getScanControl([String? value]) {
    return preferences?.getString("scanControl") ?? value ?? "";
  }

  static bool getAddScanHistoryValue([bool? value]) {
    return preferences?.getBool("addScanHistory") ?? value ?? true;
  }

  static String getFocus([String? value]) {
    return preferences?.getString("focus") ?? value ?? "";
  }
}
