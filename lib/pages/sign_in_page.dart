import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:users_publications/themes/theme_charger.dart';
import 'package:users_publications/helpers/email_validator.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SafeArea(
                top: true,
                bottom: false,
                child: Icon(
                  FontAwesomeIcons.handPeace,
                  color: appTheme.accentColor.withOpacity(0.8),
                  size: size.height * 0.15,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Regístrate',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.9)),
              ),
              _SignInForm()
            ],
          ),
        ),
      ),
    );
  }
}

class _SignInForm extends StatefulWidget {
  @override
  __SignInFormState createState() => __SignInFormState();
}

class __SignInFormState extends State<_SignInForm> {
  final GlobalKey<FormState> _forKey = GlobalKey<FormState>();
  String _name = '';
  String _lastname = '';
  String _email = '';
  String _password = '';
  String _repeatPassword = '';

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _forKey,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                  labelText: 'Nombre', icon: Icon(Icons.person)),
              onChanged: (name) => _name = name,
              validator: (name) =>
                  (name!.length < 2) ? 'Nombre no valido.' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Apellido', icon: Icon(Icons.person)),
              onChanged: (lastname) => _lastname = lastname,
              validator: (lastname) =>
                  (lastname!.length < 2) ? 'Nombre no valido.' : null,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  labelText: 'Email', icon: Icon(Icons.alternate_email)),
              onChanged: (email) => _email = email,
              validator: (email) => validateEmail(email!),
            ),
            TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: 'Contraseña', icon: Icon(Icons.lock)),
                onChanged: (pass) => _password = pass,
                validator: (pass) {
                  if (pass!.length < 6)
                    return 'La contraseña debe tener por lo menos 6 caracteres.';
                  else if (pass != _repeatPassword) {
                    return 'Las contraseña no coinciden.';
                  } else {
                    return null;
                  }
                }),
            TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: 'Repite tu Contraseña',
                    icon: Icon(Icons.lock_outline)),
                onChanged: (pass) => _repeatPassword = pass,
                validator: (pass) {
                  if (pass!.length < 6)
                    return 'La contraseña debe tener por lo menos 6 caracteres.';
                  else if (pass != _password) {
                    return 'Las contraseña no coinciden.';
                  } else {
                    return null;
                  }
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
                      print(
                          '$_email $_password $_repeatPassword $_name $_lastname');
                    }
                  },
                  child: Text('Regístrarse')),
            ),
          ],
        ));
  }
}
