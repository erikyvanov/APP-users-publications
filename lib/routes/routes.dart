import 'package:flutter/material.dart';
import 'package:users_publications/pages/home_page.dart';

import 'package:users_publications/pages/init_page.dart';
import 'package:users_publications/pages/login_page.dart';
import 'package:users_publications/pages/sign_in_page.dart';

class Route {
  final Widget page;
  final String name;

  Route({required this.page, required this.name});
}

final init = Route(page: InitPage(), name: 'init');
final login = Route(page: LoginPage(), name: 'login');
final home = Route(page: HomePage(), name: 'home');
final signIn = Route(page: SignInPage(), name: 'sign_in');

final routes = {
  init.name: (BuildContext context) => init.page,
  login.name: (BuildContext context) => login.page,
  home.name: (BuildContext context) => home.page,
  signIn.name: (BuildContext context) => signIn.page,
};
