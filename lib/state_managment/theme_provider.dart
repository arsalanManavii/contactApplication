import 'package:contact_application/util/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'package:contact_application/util/shared_preferences.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode =
      Preferences.isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  // Constructor to load the theme when the app starts
  ThemeProvider() {
    _loadTheme();
  }

  bool get isDarkTheme => themeMode == ThemeMode.dark;

  void _loadTheme() async {
    bool isDark = Preferences
        .isDarkTheme; // Load theme preference from shared preferences
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void toggleTheme() {
    Preferences.setTheme(
        themeMode == ThemeMode.light); // Save the opposite of current theme
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(
        // AppBar title, or any large title
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        // Body text (ListTile title)
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        // Subtitle (ListTile subtitle)
        color: Colors.white70,
        fontSize: 14,
      ),
      labelLarge: TextStyle(
        // TextField label
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        // Small text (hint text or captions)
        color: Colors.white60,
        fontSize: 12,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    scaffoldBackgroundColor: Colors.grey.shade900,
  );

  static final lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        // AppBar title, or any large title
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        // AppBar title, or any large title
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        // Body text (ListTile title)
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        // Subtitle (ListTile subtitle)
        color: Colors.black54,
        fontSize: 14,
      ),
      labelLarge: TextStyle(
        // TextField label
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        // Small text (hint text or captions)
        color: Colors.black45,
        fontSize: 12,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    scaffoldBackgroundColor: Color(0xffeeeeee),
  );
}
