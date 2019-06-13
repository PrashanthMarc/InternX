import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swecha/misc/palette.dart';
import 'package:swecha/misc/widget_utils.dart';
import 'package:swecha/widgets/full_app_logo.dart';

class SplashScreen extends StatefulWidget {
  static const String TAG = "SPLASH";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "scaffold-splash");

  NavigatorState _navigator;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    await Future.delayed(
      Duration(seconds: 2),
      () async => WidgetUtils.proceedToAuth(context, replaceAll: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(Palette.overlayStyle);

    if (_navigator == null) {
      _navigator = Navigator.of(context, rootNavigator: true);
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Center(
        child: FullAppLogo(
            // key: ValueKey("image-logo"),

            ),
      ),
    );
  }
}
