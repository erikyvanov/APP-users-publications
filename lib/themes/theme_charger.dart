import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeChanger with ChangeNotifier {
  final ThemeData _myCustomThemeDark = ThemeData.dark().copyWith(
    accentColor: Color(0xffD80D4C),
    scaffoldBackgroundColor: Color(0xff252036),
    primaryColorLight: Color(0xffDEDDE5),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed))
            return Color(0xffD80D4C).withOpacity(0.9);
          return Color(0xffD80D4C); // Use the component's default.
        },
      ),
    )),
  );

  final ThemeData _myCustomThemeLigth = ThemeData.light().copyWith(
      accentColor: Color(0xffD80D4C),
      elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed))
              return Color(0xffD80D4C).withOpacity(0.9);
            return Color(0xffD80D4C); // Use the component's default.
          },
        ),
      )));

  bool _isDark = true;

  ThemeData get currentTheme {
    if (_isDark) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
          .copyWith(statusBarColor: Colors.transparent));

      return this._myCustomThemeDark;
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
          .copyWith(statusBarColor: Colors.transparent));

      return this._myCustomThemeLigth;
    }
  }

  bool get isDark => this._isDark;
  set isDark(bool value) {
    this.isDark = value;
    notifyListeners();
  }
}
