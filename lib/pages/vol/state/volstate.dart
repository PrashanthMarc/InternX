import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal/onesignal.dart';
import 'dart:convert';

import 'package:swecha/misc/const_utils.dart';
import 'package:swecha/misc/prefs.dart';
import 'package:swecha/misc/widget_utils.dart';
import 'package:swecha/pages/vol/model/volmodel.dart';

class VolFeedState with ChangeNotifier {
  VolFeedState() {
    // fetchList();
  }

  int _bottomBarIndex = 0;

  void setBottomBarIndex(int index) {
    _bottomBarIndex = index;
    notifyListeners();
  }

  int get bottomBarIndex => _bottomBarIndex;

  String _jsonResonse = "";
  bool _isFetching = false;

  bool get isFetching => _isFetching;

  VolFeedModel _feedModel;

  VolFeedModel get feedModel => _feedModel;
  int _error = 1;

  int get errorCode => _error;

  int _refreshTry = 0;
  /*
   * error code
   * 1 - success
   * 2 - token_not_valid
   * 3 - unknwon
   */
  Future<int> fetchList({bool isRefresh = false}) async {
    if (!isRefresh) {
      _isFetching = true;
    }
    notifyListeners();

    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };
    _error = 1;

    var response = await http.get(
      "${ConstUtils.baseUrl}voluntee_feed/",
      headers: headers,
    );

    // print(response.body);
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
          _feedModel = VolFeedModel.fromJson(json);
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
        await tokenErrorHome();
      }
    } else {
      _error = 3;
    }

    if (!isRefresh) {
      _isFetching = false;
    }
    notifyListeners();
    await oneSignalUpdate();
    return _error;
  }

  Future<void> refreshToken() async {
    String refreshToken = await Prefs.getString("refresh");

    // print("refreshToken");

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

  bool _tokenError = false;

  bool get tokenError => _tokenError;

  Future<void> tokenErrorHome() async {
    await Prefs.clear();
    _tokenError = true;
    notifyListeners();
    return null;
  }

  Future<void> oneSignalUpdate() async {
    int timeUpdated = await Prefs.getInt("onesignalUpdated");
    Duration duration = DateTime.fromMillisecondsSinceEpoch(timeUpdated)
        .difference(DateTime.now());
    // print(duration.inDays);
    if (duration.inDays >= 1 || timeUpdated == 0) {
      String playerId = await Prefs.getString("playerId");

      String token = await Prefs.getString("token");

      Map<String, String> headers = {
        "Authorization": "Bearer $token",
      };
      _error = 1;

      Map<String, String> keys = {"nkey": playerId};

      var response = await http.post("${ConstUtils.baseUrl}update_pushkey/",
          headers: headers, body: keys);

      // print(response.body);
      if (response.statusCode == 200) {
        await Prefs.setInt(
            "onesignalUpdated", DateTime.now().millisecondsSinceEpoch);
      }
    }
    return null;
  }

  int page = 0;
  bool feedEnd = false;
  bool isLoadingMore = false;

  loadMore() async {
    if (!isLoadingMore) {
      if (_feedModel.feeds != null && feedModel.feeds.length != 0) {
        // if (int.parse(feedModel.totalPages) >= page) {
        //   await fetchNextPage(isRefresh: true);
        // } else {
        //   feedEnd = true;
        // }
      }
    }
    notifyListeners();
  }

  Future<int> fetchLoadMoreList({bool isRefresh = false}) async {
    if (!isRefresh) {
      _isFetching = true;
    }
    notifyListeners();

    String token = await Prefs.getString("token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };
    _error = 1;

    var response = await http.get(
      "${ConstUtils.baseUrl}voluntee_feed/",
      headers: headers,
    );

    // print(response.body);
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
          _feedModel = VolFeedModel.fromJson(json);
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
        await tokenErrorHome();
      }
    } else {
      _error = 3;
    }

    if (!isRefresh) {
      _isFetching = false;
    }
    notifyListeners();
    await oneSignalUpdate();
    return _error;
  }
}
