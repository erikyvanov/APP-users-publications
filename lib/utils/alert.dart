import 'package:flutter/material.dart';

import 'package:users_publications/pages/login_page.dart';

void showAlert(BuildContext context, String message) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Aceptar'))
          ],
        );
      });
}

void showAlertAndReturnLogin(BuildContext context, String message) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.of(context)
                    .pushNamedAndRemoveUntil(LoginPage.name, (route) => false),
                child: Text('Aceptar'))
          ],
        );
      });
}
