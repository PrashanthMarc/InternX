import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:swecha/misc/const_utils.dart';
import 'package:swecha/misc/prefs.dart';

class LoginState with ChangeNotifier {
  LoginState();

  String _jsonResonse = "";
  bool _isFetching = false;

  bool get isFetching => _isFetching;

  Future<bool> loginUser(String username, String password) async {
    _isFetching = true;
    notifyListeners();

    Map<String, String> userLogins = {
      "username": username,
      "password": password
    };
    bool _error = false;

    var response = await http.post(
      "${ConstUtils.baseUrl}token",
      body: userLogins,
    );
    if (response.statusCode == 200) {
      _jsonResonse = response.body;

      if (_jsonResonse.isNotEmpty) {
        Map<String, dynamic> json = jsonDecode(_jsonResonse);
        if (json["detail"] != null) {
          _error = true;
        } else {
          await Prefs.setString("token", json["access"]);
          await Prefs.setString("refresh", json["refresh"]);
          _error = false;
        }
      }
    }

    _isFetching = false;
    notifyListeners();
    return _error;
  }
}
