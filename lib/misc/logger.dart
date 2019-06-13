/**
 * Copyright (c) Foodie Labs, Inc  - All Rights Reserved
 * 
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Karthik Ponnam for Foodie Labs, Inc , April 2019.
 */

import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:meta/meta.dart' show required;

class Logger {
  static const String TAG = "LOGGER";

  static void log(String tag, {@required String message}) {
    assert(tag != null);
    print("[$tag] $message");
  }

  static Future<bool> isSimulator() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      try {
        final iOS = await deviceInfo.iosInfo;
        if (iOS != null && iOS.isPhysicalDevice) return false;
      } catch (error) {
        log(TAG, message: "isSimulator failed, error: $error");
      }
    } else {
      try {
        final android = await deviceInfo.androidInfo;
        if (android != null && android.isPhysicalDevice) return false;
      } catch (error) {
        log(TAG, message: "isSimulator failed, error: $error");
      }
    }

    return true;
  }
}
