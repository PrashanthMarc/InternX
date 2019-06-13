/**
 * Copyright (c) Foodie Labs, Inc  - All Rights Reserved
 * 
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Karthik Ponnam for Foodie Labs, Inc , April 2019.
 */

import 'dart:async';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:swecha/i18n/messages_all.dart';
import 'package:swecha/misc/date_utils.dart';
import 'package:swecha/misc/logger.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
// flutter packages pub run intl_translation:extract_to_arb --output-dir=lib/i18n lib/i18n/translation.dart
// flutter packages pub run intl_translation:generate_from_arb --output-dir=lib/i18n --no-use-deferred-loading lib/i18n/translation.dart lib/i18n/intl_*.arb

// flutter packages pub run intl_translation:extract_to_arb --output-dir=lib/i18n lib/i18n/translation.dart && flutter packages pub run intl_translation:generate_from_arb --output-dir=lib/i18n --no-use-deferred-loading lib/i18n/translation.dart lib/i18n/intl_*.arb

class Translation {
  static const String TAG = "I18N";
  static const _TranslationDelegate delegate = const _TranslationDelegate();

  static Future<Translation> load(Locale locale) {
    Logger.log(TAG, message: "Loading for locale: $locale");
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      initializeDateFormatting(localeName);
      DateUtils.init();
      return Translation();
    });
  }

  static Translation of(BuildContext context) {
    return Localizations.of<Translation>(context, Translation);
  }

  String get appName => 'Fudy';

  String get slogan => 'We Call, We help';

  String get loading => Intl.message(
        "Loading...",
        name: "loading",
      );

  String get cameraLabel => Intl.message(
        "Camera",
        name: "cameraLabel",
      );

  String get galleryLabel => Intl.message(
        "Gallery",
        name: "galleryLabel",
      );
}

class _TranslationDelegate extends LocalizationsDelegate<Translation> {
  const _TranslationDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'pt', 'es'].contains(locale.languageCode);

  @override
  Future<Translation> load(Locale locale) => Translation.load(locale);

  @override
  bool shouldReload(_TranslationDelegate old) => false;
}
