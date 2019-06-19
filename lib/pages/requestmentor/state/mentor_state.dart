import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:swecha/misc/const_utils.dart';
import 'package:swecha/misc/prefs.dart';
import 'package:swecha/pages/requestmentor/model/mentor_model.dart';

class MentorState with ChangeNotifier {
  MentorState() {
    fetchMentors();
  }

  String _jsonResonse = "";
  bool _isFetching = false;

  bool get isFetching => _isFetching;

  MentorModel _mentorModel;

  MentorModel get mentorModel => _mentorModel;
  int _error = 1;

  int get errorCode => _error;

  /*
   * error code
   * 1 - success
   * 2 - token_not_valid
   * 3 - unknwon
   */
  Future<int> fetchMentors() async {
    _isFetching = true;
    notifyListeners();

    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };
    _error = 1;

    var response = await http.get(
      "${ConstUtils.baseUrl}request_mentor/",
      headers: headers,
    );
    if (response.statusCode == 200) {
      _jsonResonse = response.body;
      print(_jsonResonse);
      print(response.statusCode);
      if (_jsonResonse.isNotEmpty) {
        var json = jsonDecode(_jsonResonse);

        if (json['code'] != null) {
          _error = 2;
        } else {
          _mentorModel = MentorModel.fromJson(json);
          _error = 1;
        }
      } else {
        _error = 3;
      }
    } else if (response.statusCode == 401) {
      _error = 2;
      // await Prefs.clear();
      refreshToken();
    } else {
      _error = 3;
    }

    _isFetching = false;
    notifyListeners();
    return _error;
  }

  Future<void> refreshToken() async {
    await fetchNewToken();

    fetchMentors();
  }

  bool _tokenError = false;

  bool get tokenError => _tokenError;

  Future<void> tokenErrorHome() async {
    await Prefs.clear();
    _tokenError = true;
    notifyListeners();
    return;
  }

  Future<void> fetchNewToken() async {
    String refreshToken = await Prefs.getString("refresh");
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
        tokenErrorHome();
      }
    } else {
      _error = true;
      tokenErrorHome();
    }
    return null;
  }

  bool _isQueryPosting = false;
  bool get isQueryPosting => _isQueryPosting;

  Future<void> postQuery(String query) async {
    _isQueryPosting = true;
    notifyListeners();

    await fetchNewToken();

    String token = await Prefs.getString("token");
    String uid = (await Prefs.getInt("userId")).toString();

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };

    Map<String, String> queryData = {
      "body": query,
      "is_resolved": "false",
      "uid": uid
    };
    bool _error = false;

    var response = await http.post(
      "${ConstUtils.baseUrl}request_mentor/",
      headers: headers,
      body: queryData,
    );

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      _error = false;
      // await fetchMentors();
    } else {
      _error = true;
    }
    _isQueryPosting = false;
    notifyListeners();
    return _error;
  }
}
