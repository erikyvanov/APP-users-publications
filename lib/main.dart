import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:users_publications/pages/home_page.dart';
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
    final tokenHasExpired = userPreferences.token == ''
        ? true
        : JwtDecoder.isExpired(userPreferences.token);

    final String initialRoute = userPreferences.init
        ? InitPage.name
        : tokenHasExpired
            ? LoginPage.name
            : HomePage.name;

    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      theme: Provider.of<ThemeChanger>(context).currentTheme,
      debugShowCheckedModeBanner: false,
      title: 'Users-Publications',
      initialRoute: initialRoute,
      routes: routes,
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
