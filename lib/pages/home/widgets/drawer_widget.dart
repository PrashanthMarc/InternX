import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:swecha/misc/palette.dart';
import 'package:swecha/misc/prefs.dart';
import 'package:swecha/misc/widget_utils.dart';
import 'package:swecha/misc/const_utils.dart';
// import 'package:flutter_advanced_networkimage/provider.dart';

// import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String name = "";
  String track = "";
  String uid = "";
  String profilePic = "";

  bool isVol = false;

  void fetchUserDetails() async {
    name = await Prefs.getString("name");
    track = await Prefs.getString("track");
    uid = await Prefs.getString("uid");
    profilePic =
        "${ConstUtils.baseUrlNoSlash}${await Prefs.getString("profilePic")}";

    if (uid.toLowerCase().contains("vol") ||
        uid.toLowerCase().contains("super")) {
      isVol = true;
    }
    setState(() {});
  }

  @override
  void initState() {
    // print(await Prefs.getString("user"));
    fetchUserDetails();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 40.0,
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: profilePic == ""
                      ? AssetImage("images/logo.png")
                      : AdvancedNetworkImage(profilePic, useDiskCache: true),
                  backgroundColor: Colors.white,
                  maxRadius: 30.0,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Palette.appBlack,
                        ),
                      ),
                      Text(
                        track,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: Palette.appBlack,
                        ),
                      ),
                      Text(
                        uid,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: Palette.appBlack,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: ImageIcon(
                AssetImage("images/home.png"),
                size: 16.0,
                color: Palette.appBlack,
              ),
            ),
            title: Text(
              "Feed",
              style: TextStyle(
                fontSize: 16.0,
                color: Palette.appBlack,
                fontFamily: "Nunito",
                // fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              WidgetUtils.showFeedPage(context, isReplace: false);
            },
          ),
          if (isVol)
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ImageIcon(
                  AssetImage("images/plan.png"),
                  size: 16.0,
                  color: Palette.appBlack,
                ),
              ),
              title: Text(
                "Voluntee Feed",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Palette.appBlack,
                  fontFamily: "Nunito",
                  // fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                WidgetUtils.showVolnteeFeed(context);
              },
            ),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: ImageIcon(
                AssetImage("images/schedule.png"),
                size: 16.0,
                color: Palette.appBlack,
              ),
            ),
            title: Text(
              'Schedule',
              style: TextStyle(
                fontSize: 16.0,
                color: Palette.appBlack,
                fontFamily: "Nunito",
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              WidgetUtils.showSchedulePage(context);
            },
          ),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: ImageIcon(
                AssetImage("images/news.png"),
                size: 16.0,
                color: Palette.appBlack,
              ),
            ),
            title: Text(
              'News',
              style: TextStyle(
                fontSize: 16.0,
                color: Palette.appBlack,
                fontFamily: "Nunito",
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              WidgetUtils.showNewsPage(context);
            },
          ),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: ImageIcon(
                AssetImage("images/repos.png"),
                size: 16.0,
                color: Palette.appBlack,
              ),
            ),
            title: Text(
              'Repos',
              style: TextStyle(
                fontSize: 16.0,
                color: Palette.appBlack,
                fontFamily: "Nunito",
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              WidgetUtils.showRepoPage(context);
            },
          ),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: ImageIcon(
                AssetImage("images/mentor.png"),
                size: 16.0,
                color: Palette.appBlack,
              ),
            ),
            title: Text(
              'Request a mentor',
              style: TextStyle(
                fontSize: 16.0,
                color: Palette.appBlack,
                fontFamily: "Nunito",
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              WidgetUtils.showComingSoonPage(context);
            },
          ),
        ],
      ),
    );
  }
}
