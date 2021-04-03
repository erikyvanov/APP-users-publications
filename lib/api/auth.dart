import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:users_publications/services/user_preferences.dart';
import 'package:users_publications/utils/constants.dart';

class AuthService {
  final _prefs = UserPreferences();

  Future<Map<String, dynamic>> newUser(
      String name, String lastname, String email, String password) async {
    final Map<String, String> authData = {
      'name': name,
      'lastname': lastname,
      'email': email,
      'password': password
    };

    final url = Uri.parse('$apiHost/user');

    final resp = await http.post(url, body: json.encode(authData));

    if (resp.statusCode == 201) {
      return {'ok': true, 'message': 'El usuario se registró correctamente'};
    }

    return {'ok': false, 'message': resp.body};
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final Map<String, String> authData = {'email': email, 'password': password};

    final url = Uri.parse('$apiHost/login');

    final resp = await http.post(url, body: json.encode(authData));

    if (resp.statusCode == 201) {
      final Map<String, dynamic> decodeResp = json.decode(resp.body);

      _prefs.token = decodeResp['token']!;

      return {'ok': true};
    }

    return {'ok': false, 'message': resp.body};
  }
}
