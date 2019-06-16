import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:swecha/misc/const_utils.dart';
import 'package:swecha/misc/prefs.dart';
import 'package:swecha/misc/widget_utils.dart';
import 'package:swecha/pages/home/model/feedmodel.dart';

class FeedState with ChangeNotifier {
  FeedState() {
    // fetchList();
  }

  bool _tokenError = false;

  bool get tokenError => _tokenError;

  String _jsonResonse = "";
  bool _isFetching = false;

  bool get isFetching => _isFetching;

  FeedModel _feedModel;

  FeedModel get feedModel => _feedModel;
  int _error = 1;

  int get errorCode => _error;

  int _refreshTry = 0;
  /*
   * error code
   * 1 - success
   * 2 - token_not_valid
   * 3 - unknwon
   */
  Future<int> fetchList() async {
    _isFetching = true;
    notifyListeners();

    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };
    _error = 1;

    var response = await http.get(
      "${ConstUtils.baseUrl}feed/",
      headers: headers,
    );

    if (response.statusCode == 200) {
      _jsonResonse = response.body;

      if (_jsonResonse.isNotEmpty) {
        Map<String, dynamic> json = jsonDecode(_jsonResonse);

        if (json["token_not_valid"] != null) {
          _error = 2;
          _refreshTry += 1;
          if (_refreshTry < 4) {
            await refreshToken();
          }
        } else {
          _feedModel = FeedModel.fromJson(json);
          _refreshTry = 0;
          // try {
          //   Map<String, dynamic> payload = ConstUtils.parseJwt(json["access"]);
          //   await Prefs.setInt("userId", payload["user_id"]);
          //   await Prefs.setInt("exp", payload["exp"]);
          // } catch (er) {}
          // await Prefs.setString("token", json["access"]);
          // await Prefs.setString("refresh", json["refresh"]);
          _error = 1;
        }
      } else {
        _error = 3;
      }
    } else if (response.statusCode == 401) {
      _error = 2;
      _refreshTry += 1;
      if (_refreshTry < 4) {
        await refreshToken();
      } else {
        await Prefs.clear();
        _tokenError = true;
      }
    } else {
      _error = 3;
    }

    _isFetching = false;
    notifyListeners();
    return _error;
  }

  Future<void> refreshToken() async {
    String refreshToken = await Prefs.getString("refresh");

    print(refreshToken);

    Map<String, String> refreshData = {"refresh": refreshToken};
    bool _error = false;

    var response = await http.post(
      "${ConstUtils.baseUrl}token/refresh/",
      body: refreshData,
    );

    if (response.statusCode == 200) {
      _jsonResonse = response.body;

      if (_jsonResonse.isNotEmpty) {
        Map<String, dynamic> json = jsonDecode(_jsonResonse);
        if (json["detail"] != null) {
          _error = true;
          await Prefs.clear();
        } else {
          try {
            Map<String, dynamic> payload = ConstUtils.parseJwt(json["access"]);
            await Prefs.setInt("userId", payload["user_id"]);
            await Prefs.setInt("exp", payload["exp"]);
          } catch (er) {}
          await Prefs.setString("token", json["access"]);
          _error = false;
        }
      } else {
        _error = true;
      }
    } else {
      _error = true;
    }

    fetchList();
  }
}
