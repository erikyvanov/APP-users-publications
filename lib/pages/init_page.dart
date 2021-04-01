import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:users_publications/routes/routes.dart';
import 'package:users_publications/themes/theme_charger.dart';
import 'package:users_publications/services/user_preferences.dart';

import 'package:users_publications/widgets/slideshow.dart';

class InitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appTheme = Provider.of<ThemeChanger>(context);

    // print(size.width);

    return Scaffold(
      // backgroundColor: Colors.white12,
      body: SlideShow(
          bulletPrimario: 15,
          colorPrimario: appTheme.currentTheme.accentColor,
          slides: [
            _Slide(
                FlutterLogo(
                  size: size.height * 0.55,
                ),
                'Esta es una aplicación de prueba hecha en Flutter.'),
            _Slide(
                SvgPicture.asset(
                  'assets/gopher-front.svg',
                  height: size.height * 0.55,
                ),
                'Utiliza una API REST hecha en Golang'),
            _Slide(
                SvgPicture.asset(
                  'assets/mongodb-icon-1.svg',
                  height: size.height * 0.55,
                ),
                'Usa una base de datos NoSQL en MongoDB'),
            _Slide(
                SvgPicture.asset(
                  'assets/jwtio-json-web-token.svg',
                  height: size.height * 0.55,
                ),
                'Usa Json Web Token para la autenticación de usuarios'),
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 200, height: 60),
                child: ElevatedButton(
                  onPressed: () {
                    final UserPreferences prefs = UserPreferences();
                    prefs.init = false;

                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(login.name, (route) => false);
                  },
                  child: size.width > 896
                      ? Text(
                          'Continuar',
                          style: TextStyle(fontSize: 20),
                        )
                      : Text('Continuar'),
                ),
              ),
            )
          ]),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget child;
  final String text;

  _Slide(this.child, this.text);

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(28.0),
          child: child,
        ),
        Text(
          this.text,
          style: TextStyle(
              color: appTheme.currentTheme.primaryColorLight, fontSize: 17),
        ),
      ],
    );
  }
}
