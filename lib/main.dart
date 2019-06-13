import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:swecha/i18n/translation.dart';
import 'package:swecha/misc/palette.dart';
import 'package:swecha/pages/splash_screen.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
      
    
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
