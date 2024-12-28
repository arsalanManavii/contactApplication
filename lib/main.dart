import 'package:contact_application/helper/database_helper.dart';
import 'package:contact_application/screens/home_screen.dart';
import 'package:contact_application/state_managment/provider.dart';
import 'package:contact_application/state_managment/theme_provider.dart';
import 'package:contact_application/util/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.initfun();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const Application(),
    ),
  );
  DatabaseHelper.instance.database;
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          themeMode: themeProvider.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          debugShowCheckedModeBanner: false,
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => ContactProvider()),
            ],
            child: const HomeScreen(),
          ),
        );
      },
    );
  }
}
