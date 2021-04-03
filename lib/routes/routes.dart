import 'package:flutter/material.dart';

import 'package:users_publications/pages/home_page.dart';
import 'package:users_publications/pages/init_page.dart';
import 'package:users_publications/pages/login_page.dart';
import 'package:users_publications/pages/sign_in_page.dart';

final routes = {
  InitPage.name: (BuildContext context) => InitPage(),
  LoginPage.name: (BuildContext context) => LoginPage(),
  HomePage.name: (BuildContext context) => HomePage(),
  SignInPage.name: (BuildContext context) => SignInPage(),
};
