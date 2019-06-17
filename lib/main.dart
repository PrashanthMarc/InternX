import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:swecha/i18n/translation.dart';
import 'package:swecha/misc/palette.dart';
import 'package:swecha/misc/prefs.dart';
import 'package:swecha/pages/auth/login.dart';
import 'package:swecha/pages/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:swecha/i18n/translation.dart';

import 'package:onesignal/onesignal.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    String appId = "595277b7-3bde-4b1e-9728-fb620c142822";
    Map<OSiOSSettings, dynamic> none = {
      OSiOSSettings.autoPrompt: true,
      OSiOSSettings.inAppLaunchUrl: true,
    };
    OneSignal.shared.init(appId, iOSSettings: none);
    OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) async {
      await Prefs.setString("playerId", changes.to.userId);
      //will be called whenever the OS subscription changes
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        Translation.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        const Locale('en', ''),
      ],
      theme: ThemeData(
//        primaryColorBrightness: Brightness.dark,
        primaryColor: Palette.primary,
        accentColor: Palette.primary,
        cursorColor: Palette.primary,
        buttonColor: Palette.primary,
        fontFamily: 'Nunito',
      ),
      home: SplashScreen(),
    );
  }
}
