import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:users_publications/helpers/email_validator.dart';
import 'package:users_publications/routes/routes.dart';

import 'package:users_publications/themes/theme_charger.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal:
                  (size.width > 650) ? size.width * 0.1 + size.width / 6 : 0,
              vertical: (size.width > 650) ? 50 : 0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
                color: (size.width > 650)
                    ? appTheme.backgroundColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(50)),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 20,
                  ),
                  SafeArea(
                    top: true,
                    bottom: false,
                    child: Icon(
                      FontAwesomeIcons.solidHandPeace,
                      color: appTheme.accentColor.withOpacity(0.8),
                      size: size.height * 0.2,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Iniciar Sesión',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.9)),
                  ),
                  _LoginForm(),
                  // Spacer(),
                  _Footer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('¿Aún no tienes cuenta? '),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, signIn.name);
            },
            child: Text(
              'Regístrate',
              style: TextStyle(color: Colors.pink),
            ))
      ],
    );
  }
}

class _LoginForm extends StatefulWidget {
  @override
  __LoginFormState createState() => __LoginFormState();
}

class __LoginFormState extends State<_LoginForm> {
  final GlobalKey<FormState> _forKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Form(
        key: _forKey,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  labelText: 'Email', icon: Icon(Icons.alternate_email)),
              onChanged: (email) => _email = email,
              validator: (email) => validateEmail(email!),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: 'Contraseña', icon: Icon(Icons.lock)),
                onChanged: (pass) => _password = pass,
                validator: (pass) {
                  if (pass!.length < 6)
                    return 'La contraseña debe tener por lo menos 6 caracteres.';
                  else
                    return null;
                }),
            SizedBox(
              height: 40,
            ),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 150, height: 40),
              child: ElevatedButton(
                  onPressed: () {
                    if (_forKey.currentState!.validate()) {
                      // TODO: Enviar a servidor
                      print('Bien');
                      print('$_email $_password');
                    }
                  },
                  child: Text('Entrar')),
            ),
          ],
        ),
      ),
    );
  }
}
