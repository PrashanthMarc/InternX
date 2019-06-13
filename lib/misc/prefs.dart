// ///
// /// Copyright (C) 2018 Andrious Solutions
// ///
// /// This program is free software; you can redistribute it and/or
// /// modify it under the terms of the GNU General Public License
// /// as published by the Free Software Foundation; either version 3
// /// of the License, or any later version.
// ///
// /// You may obtain a copy of the License at
// ///
// ///  http://www.apache.org/licenses/LICENSE-2.0
// ///
// ///
// /// Unless required by applicable law or agreed to in writing, software
// /// distributed under the License is distributed on an "AS IS" BASIS,
// /// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// /// See the License for the specific language governing permissions and
// /// limitations under the License.
// ///
// ///          Created  05 Jun 2018
// ///
// library prefs;

// import 'dart:async';

// import 'package:shared_preferences/shared_preferences.dart';

// class PreferenceKey {
//   static const String bookmarkIds = 'bookmarkIds';
//   static const String bookmarkHostels = 'bookmarkHostels';
// }

// /// The App's Preferences.
// class Prefs {
//   static Future<SharedPreferences> get _instance async =>
//       SharedPreferences.getInstance();

//   /// Returns a Future.
//   static Future<Set<String>> getKeys() async =>
//       (await _instance).getKeys() ?? Set();

//   /// Returns a Future.
//   static Future<dynamic> get(String key) async => (await _instance).get(key);

//   /// Returns a Future.
//   static Future<bool> getBool(String key, {bool defaultValue = false}) async =>
//       (await _instance).getBool(key) ?? defaultValue;

//   /// Returns a Future.
//   static Future<int> getInt(String key) async =>
//       (await _instance).getInt(key) ?? 0;

//   /// Returns a Future.
//   static Future<double> getDouble(String key) async =>
//       (await _instance).getDouble(key) ?? 0.0;

//   /// Returns a Future.
//   static Future<String> getString(String key) async =>
//       (await _instance).getString(key) ?? "";

//   /// Returns a Future.
//   static Future<List<String>> getStringList(String key) async =>
//       (await _instance).getStringList(key) ?? [];

//   /// Saves a boolean [value] to persistent storage in the background.
//   /// If [value] is null, this is equivalent to calling [remove()] on the [key].
//   static Future<bool> setBool(String key, bool value) async =>
//       (await _instance).setBool(key, value);

//   /// Saves an integer [value] to persistent storage in the background.
//   /// If [value] is null, this is equivalent to calling [remove()] on the [key].
//   static Future<bool> setInt(String key, int value) async =>
//       (await _instance).setInt(key, value);

//   /// Saves a double [value] to persistent storage in the background.
//   /// Android doesn't support storing doubles, so it will be stored as a float.
//   /// If [value] is null, this is equivalent to calling [remove()] on the [key].
//   static Future<bool> setDouble(String key, double value) async =>
//       (await _instance).setDouble(key, value);

//   /// Saves a string [value] to persistent storage in the background.
//   /// If [value] is null, this is equivalent to calling [remove()] on the [key].
//   static Future<bool> setString(String key, String value) async =>
//       (await _instance).setString(key, value);

//   /// Saves a list of strings˜ [value] to persistent storage in the background.
//   /// If [value] is null, this is equivalent to calling [remove()] on the [key].
//   static Future<bool> setStringList(String key, List<String> value) async =>
//       (await _instance).setStringList(key, value);

//   /// Removes an entry from persistent storage.
//   static Future<bool> remove(String key) async => (await _instance).remove(key);

//   /// Completes with true once the user preferences for the app has been cleared.
//   static Future<bool> clear() async => (await _instance).clear();
// }
