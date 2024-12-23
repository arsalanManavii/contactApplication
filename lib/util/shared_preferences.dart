import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences sharedPreferences;

  // Initialize SharedPreferences
  static initfun() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // Save the theme preference (dark or light)
  static void setTheme(bool isDarkTheme) {
    sharedPreferences.setBool('isDarkTheme', isDarkTheme);
  }

  // Get the saved theme preference (dark or light), default to light if not set
  static bool get isDarkTheme => sharedPreferences.getBool('isDarkTheme') ?? false;
}
