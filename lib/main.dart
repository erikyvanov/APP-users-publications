import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:users_publications/routes/routes.dart';
import 'package:users_publications/themes/theme_charger.dart';

void main() => runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => ThemeChanger())],
    child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeChanger>(context).currentTheme,
      debugShowCheckedModeBanner: false,
      title: 'Users-Publications',
      initialRoute: init.name,
      routes: routes,
    );
  }
}
