import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swecha/misc/prefs.dart';
import 'package:swecha/pages/auth/login.dart';
import 'package:swecha/pages/auth/moreinfo.dart';
import 'package:swecha/pages/auth/profile.dart';
import 'package:swecha/pages/home/comingsoon.dart';
import 'package:swecha/pages/home/home.dart';
import 'package:swecha/pages/home/request_mentor.dart';
import 'package:swecha/pages/news/news.dart';
import 'package:swecha/pages/repos/repo.dart';
import 'package:swecha/pages/requestmentor/mentor.dart';
import 'package:swecha/pages/schedule/assignment.dart';
import 'package:swecha/pages/schedule/schedule.dart';
import 'package:swecha/pages/vol/volfeed.dart';

class WidgetUtils {
  static const String TAG = "WIDGET_UTILS";
  String tag = LogInPage.TAG;
  Widget page = LogInPage();

  static void proceedToAuth(
    BuildContext context, {
    bool replaceAll = false,
    String invite,
  }) async {
    String tag;
    Widget page;

//    tag = MeetupOwnerPage.TAG;
//    page = MeetupOwnerPage();

    tag = LogInPage.TAG;
    page = LogInPage();

    // tag = FeedPage.TAG;
    // page = FeedPage();

    String token = await Prefs.getString("token");
    print(token);

    if (token != "") {
      tag = FeedPage.TAG;
      page = FeedPage();
    }

    var route;

    route = CupertinoPageRoute(
      maintainState: true,
      settings: RouteSettings(name: tag),
      builder: (context) => page,
    );

    if (replaceAll) {
      Navigator.of(context).pushAndRemoveUntil(
        route,
        (route) => false,
      );
    } else {
      Navigator.of(context).push(
        route,
      );
    }
  }

  // if (await Prefs.getBool("loggedIn")) {
  // tag = HomePage.TAG;
  // page = HomePage();
  // } else {
  // tag = LogInPage.TAG;
  // page = LogInPage();
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

  // static void showAddFeedPage(BuildContext context) async {
  //   String tag = AddFeedPage.TAG;
  //   Widget page = AddFeedPage();

  //   final route = CupertinoPageRoute<bool>(
  //       maintainState: true,
  //       settings: RouteSettings(name: tag),
  //       builder: (context) => page,
  //       fullscreenDialog: true);
  //   Navigator.of(context).push(route);
  // }

  static void showMoreInfoPage(BuildContext context) async {
    String tag = MoreInfoPage.TAG;
    Widget page = MoreInfoPage();

    final route = CupertinoPageRoute<bool>(
      maintainState: true,
      settings: RouteSettings(name: tag),
      builder: (context) => page,
    );
    Navigator.of(context).push(route);
  }

  static void showProfilePage(BuildContext context) async {
    String tag = ProfilePage.TAG;
    Widget page = ProfilePage();

    final route = CupertinoPageRoute<bool>(
      maintainState: true,
      settings: RouteSettings(name: tag),
      builder: (context) => page,
    );
    Navigator.of(context).push(route);
  }

  static void showFeedPage(BuildContext context, {isReplace = false}) async {
    String tag = FeedPage.TAG;
    Widget page = FeedPage();

    final route = CupertinoPageRoute<bool>(
      maintainState: true,
      settings: RouteSettings(name: tag),
      builder: (context) => page,
    );
    if (isReplace) {
      Navigator.of(context).pushAndRemoveUntil(route, (route) => false);
    } else {
      Navigator.of(context).push(route);
    }
  }

  static void showVolnteeFeed(BuildContext context) async {
    String tag = VolFeedPage.TAG;
    Widget page = VolFeedPage();

    final route = CupertinoPageRoute<bool>(
      maintainState: true,
      settings: RouteSettings(name: tag),
      builder: (context) => page,
    );
    Navigator.of(context).push(route);
  }

  static void showAssignmentPage(
      BuildContext context, String title, String data) async {
    String tag = AssignmentPage.TAG;
    Widget page = AssignmentPage(
      title: title,
      data: data,
    );

    final route = CupertinoPageRoute<bool>(
      maintainState: true,
      settings: RouteSettings(name: tag),
      builder: (context) => page,
    );
    Navigator.of(context).push(route);
  }

  static void showRepoPage(BuildContext context) async {
    String tag = RepoPage.TAG;
    Widget page = RepoPage();

    final route = CupertinoPageRoute<bool>(
      maintainState: true,
      settings: RouteSettings(name: tag),
      builder: (context) => page,
    );
    Navigator.of(context).push(route);
  }

  static void showNewsPage(BuildContext context) async {
    String tag = NewsPage.TAG;
    Widget page = NewsPage();

    final route = CupertinoPageRoute<bool>(
      maintainState: true,
      settings: RouteSettings(name: tag),
      builder: (context) => page,
    );
    Navigator.of(context).push(route);
  }

  static void showSchedulePage(BuildContext context) async {
    String tag = SchedulePage.TAG;
    Widget page = SchedulePage();

    final route = CupertinoPageRoute<bool>(
      maintainState: true,
      settings: RouteSettings(name: tag),
      builder: (context) => page,
    );
    Navigator.of(context).push(route);
  }

// Drawer Items

  static void showRequestMentorPage(BuildContext context) async {
    String tag = MentorPage.TAG;
    Widget page = MentorPage();

    final route = CupertinoPageRoute<bool>(
      maintainState: true,
      settings: RouteSettings(name: tag),
      builder: (context) => page,
    );
    Navigator.of(context).push(route);
  }

  static void showComingSoonPage(BuildContext context) async {
    String tag = ComingSoonPage.TAG;
    Widget page = ComingSoonPage();

    final route = CupertinoPageRoute<bool>(
      maintainState: true,
      settings: RouteSettings(name: tag),
      builder: (context) => page,
    );
    Navigator.of(context).push(route);
  }

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

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
                opacity: animation,
                child: child,
              ),
        );
}
