import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_publications/pages/init_page.dart';
import 'package:users_publications/pages/login_page.dart';

import 'package:users_publications/routes/routes.dart';
import 'package:users_publications/themes/theme_charger.dart';
import 'package:users_publications/services/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new UserPreferences();
  await prefs.initPrefs();

  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeChanger())],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  final userPreferences = UserPreferences();

  @override
  Widget build(BuildContext context) {
    final String initialRoute =
        userPreferences.init ? InitPage.name : LoginPage.name;

    return MaterialApp(
      theme: Provider.of<ThemeChanger>(context).currentTheme,
      debugShowCheckedModeBanner: false,
      title: 'Users-Publications',
      initialRoute: initialRoute,
      routes: routes,
    );
  }
}
