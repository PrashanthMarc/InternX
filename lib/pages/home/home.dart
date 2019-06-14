import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:swecha/misc/const_utils.dart';
import 'package:swecha/misc/date_utils.dart';
import 'package:swecha/misc/prefs.dart';
import 'package:swecha/misc/widget_utils.dart';
import 'package:swecha/pages/home/model/feedmodel.dart';
import 'package:swecha/pages/home/state/feedstate.dart';
// import 'package:flutter_advanced_networkimage/provider.dart';

import 'package:swecha/pages/home/widgets/drawer_widget.dart';
import 'package:swecha/widgets/full_app_logo.dart';
import 'package:swecha/widgets/white_app_bar.dart';
import 'package:swecha/misc/palette.dart';
import 'package:swecha/pages/home/widgets/feedpost.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
// import 'package:fudy/pages/meetme/widget/star_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:http/http.dart' as http;

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
  static String TAG = "FEEDPAGE";
}

class _FeedPageState extends State<FeedPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "feed_page");

  FeedModel feedModel;
  DateFormat dateFormat = new DateFormat("dd/MM/yyyy, HH:mm:ss a");

  _buildDrawerContent(BuildContext context) {
    return DrawerWidget();
  }

// REVIEW WRITE
  _buildFeedPost() {
    return FeedPostWidget(context: context);
  }

  _refreshList() {
    setState(() {});
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
          child: _buildFeedPost(),
        );
      },
    );
  }

  _buildFeedList() {
    return Consumer<FeedState>(builder: (context, fState, child) {
      if (fState.isFetching) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (!fState.isFetching && fState.errorCode == 401) {
        WidgetUtils.proceedToAuth(context);
      }
      if (fState.feedModel != null && fState.feedModel.feeds.length > 0) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return _buildCardPost(fState.feedModel.feeds[index]);
            return Padding(
              padding: const EdgeInsets.only(
                  top: 4.0, left: 8.0, right: 8.0, bottom: 4.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(fState.feedModel.feeds[index].body),
                ),
              ),
            );
          },
          itemCount: fState.feedModel.feeds.length,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
        );
      }
      if (fState.feedModel != null && fState.feedModel.feeds.length == 0) {
        return Center(
          child: Text("Unable to fetch Feed"),
        );
      }
      if (fState.feedModel == null) {
        return Center(
          child: Text("Unable to fetch Feed"),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FeedState>(
      builder: (_) {
        FeedState feedstate = FeedState();
        feedstate.fetchList();
        return feedstate;
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        drawer: _buildDrawerContent(context),
        appBar: WhiteAppBar(
          centerTitle: true,
          title:
              // SmallLogo(),
              Text(
            "internX",
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
        body: _buildFeedList(),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.red,
          ),
          backgroundColor: Colors.green,
          onPressed: () {
            _showFeedPostPopup();
            // WidgetUtils.showAddFeedPage(context);
          },
        ),

//           actions: <Widget>[],
//         ),
//         body: RefreshIndicator(
//           onRefresh: () async {
//             await Future.delayed(Duration(seconds: 2), () {
//               _refreshList();
//             });
//           },
//           child: ListView.builder(
// //                  padding: const EdgeInsets.all(10.0),
//             physics: const AlwaysScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               return _buildCardPost(context);
//             },
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           child: Icon(
//             Icons.add,
//             color: Colors.red,
//           ),
//           backgroundColor: Colors.green,
//           onPressed: () {
//             _showFeedPostPopup();
//           },
//         ),
      ),
    );
  }

  Widget _buildCardPost(Feeds feed) {
    print(feed.iamge);
    return Padding(
      padding: const EdgeInsets.only(
        top: 5.0,
        bottom: 5.0,
        left: 8.0,
        right: 8.0,
      ),
      // padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      child: GestureDetector(
        child: Container(
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 4.0, top: 4.0, bottom: 4.0, right: 8.0),
                            child: CircleAvatar(
                              child: Image(
                                image: AdvancedNetworkImage(
                                  "${ConstUtils.baseUrl}${feed.user}",
                                  useDiskCache: true,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  feed.user,
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  DateUtils.getLocalizedTimeAgo(
                                    dateFormat.parse(feed.info),
                                    locale: Localizations.localeOf(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        feed.body,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      feed.iamge != null && feed.iamge != ""
                          ? ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                              ),
                              child: Stack(
                                children: <Widget>[
                                  AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: Image(
                                      fit: BoxFit.fill,
                                      image: AdvancedNetworkImage(
                                        "https://source.unsplash.com/480x${300 + Random().nextInt(100)}/?food,veg",
                                        useDiskCache: true,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
