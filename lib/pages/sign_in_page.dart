import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:users_publications/api/auth.dart';

import 'package:users_publications/themes/theme_charger.dart';
import 'package:users_publications/helpers/email_validator.dart';
import 'package:users_publications/utils/alert.dart';

class SignInPage extends StatelessWidget {
  static final String name = 'sign in';

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 650) {
            return Container(
              color: appTheme.backgroundColor,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
              child: FractionallySizedBox(
                widthFactor: 0.5,
                heightFactor: 0.9,
                child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * 0.05),
                    decoration: BoxDecoration(
                        color: appTheme.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: _SignIn()),
              ),
            );
          } else {
            return _SignIn();
          }
        },
      ),
    );
  }
}

class _SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;
    final size = MediaQuery.of(context).size;

    return Center(
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

  bool _loading = false;

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
                  onPressed: _loading
                      ? null
                      : () async {
                          setState(() {
                            _loading = true;
                          });

                          if (_forKey.currentState!.validate()) {
                            final auth = await AuthService()
                                .newUser(_name, _lastname, _email, _password);

                            if (auth['ok']) {
                              showAlertAndReturnLogin(context, auth['message']);
                            } else {
                              showAlert(context, auth['message']);
                            }
                          }

                          setState(() {
                            _loading = false;
                          });
                        },
                  child: _loading
                      ? ConstrainedBox(
                          constraints:
                              BoxConstraints.tightFor(width: 30, height: 30),
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        )
                      : Text('Regístrarse')),
            ),
          ],
        ));
  }
}
