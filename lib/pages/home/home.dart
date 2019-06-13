import 'package:flutter/material.dart';
// import 'package:flutter_advanced_networkimage/provider.dart';

import 'package:swecha/pages/home/widgets/drawer_widget.dart';
import 'package:swecha/widgets/white_app_bar.dart';
import 'package:swecha/misc/palette.dart';
import 'package:swecha/pages/home/widgets/feedpost.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
  static String TAG = "FEEDPAGE";
}

class _FeedPageState extends State<FeedPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "feed_page");

  _buildDrawerContent(BuildContext context) {
    return DrawerWidget();
  }

// REVIEW WRITE

_buildFeedPost() {
    return FeedPostWidget(context: context);
  }


// FEED POST 
_showFeedPostPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(
                              top: 16.0, bottom: 8.0, left: 16.0, right: 16.0),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff0a57d2),
                              fontFamily: "Nunito",                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          top: 16.0, bottom: 8.0, left: 16.0, right: 16.0),
                      child: Text(
                        "",//heading
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Palette.appBlack,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 16.0, bottom: 8.0, left: 16.0, right: 16.0),
                          child: GestureDetector(
                            child: Text(
                              "Post",
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff0a57d2),
                                fontFamily: "Nunito",
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                _buildFeedPost(),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: _buildDrawerContent(context),
      appBar: WhiteAppBar(
        centerTitle: true,
        title: Text("internX",
        style: TextStyle(
          color: Colors.black,
          fontFamily: "Nunito",
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
        ),
        leading: IconButton(
          icon: ImageIcon(
            AssetImage("images/menu32.png"),
            color: Palette.lightGrey,
            size: 16.0,
          ),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        actions: <Widget>[],
      ),
      body: Center(
        child: Text("Some data for you"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.red,
        ),
        backgroundColor: Colors.green,
        onPressed: () {
          _showFeedPostPopup();
        },
      ),
    );
  }
}
