import 'package:floating_logger_boilerplate/packages/packages.dart';

class CustomLocalPref {
  CustomLocalPref();
  static const debugger = 'Debugger';
  static const token = 'Token';

  Future<void> saveDebugger(bool value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(debugger, value);
  }

  Future<void> saveToken(String value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(token, value);
  }

  Future<bool> getDebugger() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(debugger) ?? true;
  }

  Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(token) ?? "";
  }

  Future<void> clearToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(token);
  }
}
