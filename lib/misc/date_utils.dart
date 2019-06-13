/**
 * Copyright (c) Foodie Labs, Inc  - All Rights Reserved
 * 
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Karthik Ponnam for Foodie Labs, Inc , April 2019.
 */

import 'dart:ui' show Locale;

import 'package:intl/intl.dart';
import 'package:meta/meta.dart' show required;
import 'package:timeago/timeago.dart' as timeago;

class DateUtils {
  static init() async {
    timeago.setLocaleMessages('en', timeago.EnMessages());
    timeago.setLocaleMessages('en_short', timeago.EnShortMessages());
    timeago.setLocaleMessages('pt_BR', timeago.PtBrMessages());
    timeago.setLocaleMessages('pt_BR_short', timeago.PtBrShortMessages());
  }

  static String formatDateTime(DateTime dateTime) =>
      DateFormat.yMd().add_Hms().format(dateTime);

  static String getLocalizedTimeAgo(DateTime dateTime,
          {@required Locale locale}) =>
      timeago.format(dateTime, locale: locale.toString());
}
