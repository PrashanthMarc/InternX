import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swecha/pages/auth/login.dart';
import 'package:swecha/pages/auth/moreinfo.dart';

class WidgetUtils {
  static const String TAG = "WIDGET_UTILS";
  String tag = LogInPage.TAG;
  Widget page = LogInPage();

  

    // if (await Prefs.getBool("loggedIn")) {
    // tag = HomePage.TAG;
    // page = HomePage();
    // } else {
    // tag = LogInPage.TAG;
    // page = LogInPage();
    // }

   

  // static void showHomePage(BuildContext context) async {
  //   String tag = HomePage.TAG;
  //   Widget page = HomePage();

  //   final route = CupertinoPageRoute<bool>(
  //     maintainState: true,
  //     settings: RouteSettings(name: tag),
  //     builder: (context) => page,
  //   );
  //   Navigator.of(context).pushAndRemoveUntil(route, (route) => false);
  // }

  // static void showMapPage(BuildContext context) async {
  //   String tag = MapPage.TAG;
  //   Widget page = MapPage();

  //   final route = CupertinoPageRoute<bool>(
  //     maintainState: true,
  //     settings: RouteSettings(name: tag),
  //     builder: (context) => page,
  //   );
  //   Navigator.of(context).pushAndRemoveUntil(route, (route) => false);
  // }

  static void showLogInPage(BuildContext context) async {
    String tag = LogInPage.TAG;
    Widget page = LogInPage();

    final route = CupertinoPageRoute<bool>(
      maintainState: true,
      settings: RouteSettings(name: tag),
      builder: (context) => page,
    );
    Navigator.of(context).pushAndRemoveUntil(route, (route) => false);
  }

  static void showMoreInfoPage(BuildContext context) async {
    String tag = MoreInfoPage.TAG;
    Widget page = MoreInfoPage();

    final route = CupertinoPageRoute<bool>(
      maintainState: true,
      settings: RouteSettings(name: tag),
      builder: (context) => page,
    );
    Navigator.of(context).pushAndRemoveUntil(route, (route) => false);
  }

  // static void showHostelsIAddedPage(BuildContext context) async {
  //   String tag = HostelsIAddedPage.TAG;
  //   Widget page = HostelsIAddedPage();

  //   final route = CupertinoPageRoute<bool>(
  //     maintainState: true,
  //     settings: RouteSettings(name: tag),
  //     builder: (context) => page,
  //   );
  //   Navigator.of(context).push(route);
  // }

  // static void showMyCreditsPage(BuildContext context) async {
  //   String tag = MyCreditsPage.TAG;
  //   Widget page = MyCreditsPage();

  //   final route = CupertinoPageRoute<bool>(
  //     maintainState: true,
  //     settings: RouteSettings(name: tag),
  //     builder: (context) => page,
  //   );
  //   Navigator.of(context).push(route);
  // }

  // static void showContactUsPage(BuildContext context) async {
  //   String tag = ContactUs.TAG;
  //   Widget page = ContactUs();

  //   final route = CupertinoPageRoute<bool>(
  //     maintainState: true,
  //     settings: RouteSettings(name: tag),
  //     builder: (context) => page,
  //   );
  //   Navigator.of(context).push(route);
  // }

  // static void showAddHostelPage(BuildContext context) async {
  //   String tag = AddHostelPage.TAG;
  //   Widget page = AddHostelPage();

  //   final route = CupertinoPageRoute<bool>(
  //     maintainState: true,
  //     settings: RouteSettings(name: tag),
  //     builder: (context) => page,
  //   );
  //   Navigator.of(context).push(route);
  // }

  // static void showReferralPage(BuildContext context, FirebaseUser user) async {
  //   String tag = ReferralPage.TAG;
  //   Widget page = ReferralPage(user: user);

  //   final route = CupertinoPageRoute<bool>(
  //     maintainState: true,
  //     settings: RouteSettings(name: tag),
  //     builder: (context) => page,
  //   );
  //   Navigator.of(context).push(route);
  // }

  // static void showHostelPage(
  //     BuildContext context, ModelHostel modelHostel) async {
  //   String tag = HostelPage.TAG;
  //   Widget page = HostelPage(modelHostel);

  //   final route = CupertinoPageRoute<bool>(
  //     maintainState: true,
  //     settings: RouteSettings(name: tag),
  //     builder: (context) => page,
  //   );
  //   Navigator.of(context).push(route);
  // }

  // static void showFavouritePage(BuildContext context) async {
  //   String tag = FavouritePage.TAG;
  //   Widget page = FavouritePage();

  //   final route = CupertinoPageRoute<bool>(
  //     maintainState: true,
  //     settings: RouteSettings(name: tag),
  //     builder: (context) => page,
  //   );
  //   Navigator.of(context).push(route);
  // }

  // static void showComingSoonPage(BuildContext context) async {
  //   String tag = ComingSoonPage.TAG;
  //   Widget page = ComingSoonPage();

  //   final route = CupertinoPageRoute<bool>(
  //     maintainState: true,
  //     settings: RouteSettings(name: tag),
  //     builder: (context) => page,
  //   );
  //   Navigator.of(context).push(route);
  // }

  static void showSnackBar(
      State state, GlobalKey<ScaffoldState> key, String message) {
    if ((state?.mounted ?? false) &&
        key != null &&
        message != null &&
        message.isNotEmpty)
      key.currentState.showSnackBar(SnackBar(
        content: Text(message),
      ));
  }

  static bool isValidUrl(String url) {
    return RegExp(
            r"^(?:http(s)?:\/\/)?[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\(\)\*\+,;=.]+$")
        .hasMatch(url);
  }
}
