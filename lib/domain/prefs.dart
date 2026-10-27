import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static SharedPreferences? _instance;

  static Future<void> init() async {
    _instance ??= await SharedPreferences.getInstance();
  }

  static SharedPreferences get instance {
    if (_instance == null) {
      throw Exception('Prefs not initialized! Call await Prefs.init() in main()');
    }
    return _instance!;
  }

  static Future<void> saveRegistration({required String name, required String email, required String password}) async {
    await instance.setString('reg_name', name);
    await instance.setString('reg_email', email);
    await instance.setString('reg_password', password);
  }

  static String? getRegisteredName() => instance.getString('reg_name');

  static String? getRegisteredEmail() => instance.getString('reg_email');

  static String? getRegisteredPassword() => instance.getString('reg_password');
}
