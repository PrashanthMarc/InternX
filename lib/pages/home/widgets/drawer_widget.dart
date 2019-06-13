import 'dart:math';

import 'package:flutter/material.dart';
import 'package:swecha/misc/palette.dart';
import 'package:swecha/misc/widget_utils.dart';
// import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Palette.appBlack,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            color: Palette.appBlack,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  color: Palette.appBlack,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: ListView(
                      shrinkWrap: true,
                      primary: false,
                      children: <Widget>[
                        Container(
                          padding:
                              const EdgeInsets.only(top: 16.0, bottom: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: Image(
                                  fit: BoxFit.cover,
                                  height: 80.0,
                                  width: 80.0,
                                  image: AssetImage("images/heart.png"),),
                                //   image: AdvancedNetworkImage(
                                //     "https://source.unsplash.com/480x${300 + Random().nextInt(100)}/?food,veg",
                                //     useDiskCache: true,
                                //   ),
                                // ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "Matthew Adams",
                                  style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: 24.0,
                                  ),
                                ),
                              ),
                              Text(
                                "San Francisco",
                                style: TextStyle(
                                  color: Color(0x75ffffff),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DrawerMenuItem(
                          iconRes: "images/home32.png",
                          title: "HOME",
                          onClicked: () {
                            Navigator.of(context).pop();
                            // WidgetUtils.showDiscoverPage(context);
                              
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 1.0,
                            bottom: 1.0,
                          ),
                          child: Divider(
                            height: 1.0,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        DrawerMenuItem(
                          iconRes: "images/icon_meetme.png",
                          title: "MEETME",
                          onClicked: () {
                            Navigator.of(context).pop();
                            // WidgetUtils.showMeetmeActivePage(context);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 1.0,
                            bottom: 1.0,
                          ),
                          child: Divider(
                            height: 1.0,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        DrawerMenuItem(
                          iconRes: "images/icon_meetup.png",
                          title: "MEETUP",
                          iconSize: 22.0,
                          imagePadding: const EdgeInsets.only(
                            left: 16.0,
                            right: 10.0,
                            top: 20.0,
                            bottom: 20.0,
                          ),
                          onClicked: () {
                            Navigator.of(context).pop();
                            // WidgetUtils.showMeetupSentPage(context);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 1.0,
                            bottom: 1.0,
                          ),
                          child: Divider(
                            height: 1.0,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        DrawerMenuItem(
                          iconRes: "images/icon_social.png",
                          title: "SOCIAL",
                          onClicked: () {
                            Navigator.of(context).pop();
                            // WidgetUtils.showFollowingPage(context);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 1.0,
                            bottom: 1.0,
                          ),
                          child: Divider(
                            height: 1.0,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        DrawerMenuItem(
                          iconRes: "images/profile32.png",
                          title: "PROFILE",
                          onClicked: () {
                            Navigator.of(context).pop();
                            // WidgetUtils.showProfilePage(context);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 1.0,
                            bottom: 1.0,
                          ),
                          child: Divider(
                            height: 1.0,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        DrawerMenuItem(
                          iconRes: "images/logout32.png",
                          title: "LOGOUT",
                          onClicked: () {
                            Navigator.of(context).pop();
                            // WidgetUtils.showWelcomePage(context);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 1.0,
                            bottom: 1.0,
                          ),
                          child: Divider(
                            height: 1.0,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                child: Text(
                                  "Contact support",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xCCFFFFFF),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                // onTap: () {
                                //   Navigator.pop(context);
                                //   launch("mailto:support@fudy.co");
                                // },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    height: 16.0,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Text(
                          "Terms of service & Privacy Policy",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xccFFFFFF),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () {
                          // WidgetUtils.showTermsPage(context);
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "© Fudy, 2019",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffFFFFFF),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerMenuItem extends StatelessWidget {
  const DrawerMenuItem({
    Key key,
    @required this.iconRes,
    @required this.title,
    @required this.onClicked,
    this.iconSize = 16.0,
    this.imagePadding = const EdgeInsets.only(
      left: 16.0,
      right: 16.0,
      top: 20.0,
      bottom: 20.0,
    ),
  }) : super(key: key);

  final String iconRes;
  final String title;
  final Function() onClicked;
  final double iconSize;
  final EdgeInsets imagePadding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: imagePadding,
            child: ImageIcon(
              AssetImage(
                iconRes,
              ),
              key: Key(iconRes),
              size: iconSize,
              color: Color(0x75ffffff),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                title,
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 14.0,
                    fontFamily: "RobotoSlab"),
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        onClicked();
      },
    );
  }
}