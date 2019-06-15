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
      "${ConstUtils.baseUrl}token/",
      body: userLogins,
    );

    if (response.statusCode == 200) {
      _jsonResonse = response.body;

      if (_jsonResonse.isNotEmpty) {
        Map<String, dynamic> json = jsonDecode(_jsonResonse);
        if (json["detail"] != null) {
          _error = true;
        } else {
          try {
            Map<String, dynamic> payload = ConstUtils.parseJwt(json["access"]);
            await Prefs.setInt("userId", payload["user_id"]);
            await Prefs.setInt("exp", payload["exp"]);
          } catch (er) {}
          await Prefs.setString("token", json["access"]);
          await Prefs.setString("refresh", json["refresh"]);

          await fetchUserDetails();
          _error = false;
        }
      } else {
        _error = true;
      }
    } else {
      _error = true;
    }

    _isFetching = false;
    notifyListeners();
    return _error;
  }

  Future<bool> fetchUserDetails() async {
    // http://101.53.142.185/api/get_user_details/

    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };

    var response = await http.get(
      "${ConstUtils.baseUrl}get_user_details/",
      headers: headers,
    );
    print(response.body);

    bool _error = false;

    // {
    // "profile_pic": "/media/profile_pics/avatar_IU8R8D6.png",
    // "uid": "SUPER002",
    // "track": "Dev",
    // "name": "Karthik Ponnam"
// }

    if (response.statusCode == 200) {
      _jsonResonse = response.body;
      print(_jsonResonse);

      if (_jsonResonse.isNotEmpty) {
        Map<String, dynamic> json = jsonDecode(_jsonResonse);
        if (json["detail"] != null) {
          _error = true;
        } else {
          await Prefs.setString("profilePic", json["profile_pic"]);
          await Prefs.setString("uid", json["uid"]);
          await Prefs.setString("name", json["name"]);
          await Prefs.setString("track", json["track"]);
          _error = false;
        }
      } else {
        _error = true;
      }
    } else {
      _error = true;
    }

    return _error;
  }
}
