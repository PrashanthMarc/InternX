import 'dart:convert';

import 'package:swecha/misc/const_utils.dart';
import 'package:swecha/misc/prefs.dart';
import 'package:http/http.dart' as http;

Future<bool> refreshToken() async {
  String refreshToken = await Prefs.getString("refresh");

  // print("refreshToken");

  Map<String, String> refreshData = {"refresh": refreshToken};
  bool _error = false;

  var response = await http.post(
    "${ConstUtils.baseUrl}token/refresh/",
    body: refreshData,
  );

  String _jsonResonse = "";

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
  return _error;
}
