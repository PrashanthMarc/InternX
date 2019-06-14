import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:swecha/misc/const_utils.dart';
import 'package:swecha/misc/prefs.dart';
import 'package:swecha/pages/home/model/feedmodel.dart';

class FeedState with ChangeNotifier {
  FeedState() {
    fetchList();
  }

  String _jsonResonse = "";
  bool _isFetching = false;

  bool get isFetching => _isFetching;

  FeedModel _feedModel;

  FeedModel get feedModel => _feedModel;
  int _error = 1;

  int get errorCode => _error;

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
        } else {
          _feedModel = FeedModel.fromJson(json);
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
      await Prefs.clear();
    } else {
      _error = 3;
    }

    _isFetching = false;
    notifyListeners();
    return _error;
  }
}
