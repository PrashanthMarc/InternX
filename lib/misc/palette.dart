import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;

class Palette {
  static const Color primary = Color(0xFF3498db);
  static const Color secondary = Color(0xFF304B78);
  static const Color teal = Color(0xFF2494A2);
  // static const Color accentGreen = Color(0xFF56BCA2);
  static const Color accentBlue = Color(0xFF28A5D2);
  static const Color yellow = Color(0xFFDBB13B);
  static const Color lightYellow = Color(0xFFF9BB49);
  static const Color darkBlue = Color(0xFF2D3258);
  static const Color facebookBlue = Color(0xFF4267B2);
  static const Color disabled = Color(0xFFBDBDBD);

  static Color ok = Colors.green[500];
  static Color error = Colors.red[400];
  static Color grey = Colors.grey[600];

  static Color blue = Color(0xff2196F3);
  static Color appBlack = Color(0xff000000);
  static Color rating = Color(0xFFf39c12);
  static Color appGrey = Color(0xff44464d);

  static TextStyle header(BuildContext context, {double size = 24.0}) =>
      Theme.of(context).textTheme.title.copyWith(
            fontSize: size,
            color: darkBlue,
            fontWeight: FontWeight.bold,
          );

  static SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    // systemNavigationBarColor: Colors.white,
    // systemNavigationBarIconBrightness: Brightness.dark,
    // systemNavigationBarDividerColor: Colors.white,
  );
}
