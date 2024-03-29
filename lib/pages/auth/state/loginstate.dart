import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal/onesignal.dart';
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
          await updateOneSignalToken();
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

    await registerDevice();

    return _error;
  }

  Future<void> updateOneSignalToken() {
    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      print(changes.to.userId);
      //will be called whenever the OS subscription changes
    });
    return null;
  }

  Future<void> registerDevice() async {
    String username = 'admin@internx.xyz';
    String password = 'J35u5777#';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);

    String uid = await Prefs.getString("uid");
    String name = await Prefs.getString("name");

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': "Basic YWRtaW5AaW50ZXJueC54eXo6SjM1dTU3Nzcj"
    };

    Map<String, dynamic> body = {"name": name, "uniqueId": uid};

    var response = await Dio().post(
      "${ConstUtils.baseUrl8080}devices/",
      data: body,
      options: Options(
        headers: headers,
      ),
      onSendProgress: (int sent, int total) {
        print("$sent $total");
      },
    ).catchError((onError) {
      print(onError);
      if (onError.toString().contains("Duplicate entry ")) {
        Prefs.setBool("lr", true);
      }
    });

    if (response != null) {
      if (response.statusCode == 400 || response.statusCode == 200) {
        Prefs.setBool("lr", true);
      } else {
        Prefs.setBool("lr", false);
      }
    }

    return null;
  }
}
