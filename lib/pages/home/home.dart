import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:swecha/misc/const_utils.dart';
import 'package:swecha/misc/date_utils.dart';
import 'package:swecha/misc/palette.dart';
import 'package:swecha/misc/widget_utils.dart';
import 'package:swecha/pages/home/model/feedmodel.dart';
import 'package:swecha/pages/home/state/feedstate.dart';
import 'package:swecha/pages/home/widgets/drawer_widget.dart';
import 'package:swecha/pages/schedule/schedule_widget.dart';
import 'package:swecha/pages/schedule/state/schedulestate.dart';
import 'package:swecha/widgets/full_app_logo.dart';
import 'package:swecha/widgets/white_app_bar.dart';
import 'package:swecha/pages/home/widgets/feedpost.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:http/http.dart' as http;

class FeedPage extends StatelessWidget {
  static String TAG = "FEEDPAGE";
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "feed_page");

  FeedModel feedModel;
  DateFormat dateFormat = new DateFormat("dd/MM/yyyy, HH:mm:ss");

  _buildDrawerContent(BuildContext context) {
    return DrawerWidget();
  }

// REVIEW WRITE
  _buildFeedPost(context) {
    return FeedPostWidget(
      context: context,
      onDone: () {
        gloablFeedstate.fetchList();
      },
    );
  }

// FEED POST
  _showFeedPostPopup(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          child: _buildFeedPost(context),
        );
      },
    );
  }

  _showAppUpdatePopup(
      BuildContext context, String changeLog, String downloadUrl) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Update Available",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("We have an update"),
              Text(changeLog),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Download"),
              onPressed: () {
                launch(downloadUrl);
              },
            )
          ],
        );
      },
    );
  }

  _buildFeedList() {
    return Consumer<FeedState>(builder: (context, fState, child) {
      try {
        if (fState.feedModel.appData[0].versionNumber != ConstUtils.version) {
          print("done showing pop");
          Future.delayed(Duration(seconds: 3), () {
            _showAppUpdatePopup(context, fState.feedModel.appData[0].changeLog,
                fState.feedModel.appData[0].downloadUrl);
          });
        }
      } catch (err) {}

      if (fState.tokenError) {
        WidgetUtils.proceedToAuth(context, replaceAll: true);
      }
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
            return _buildCardPost(context, fState.feedModel.feeds[index]);
            // return Padding(
            //   padding: const EdgeInsets.only(
            //       top: 4.0, left: 8.0, right: 8.0, bottom: 4.0),
            //   child: Card(
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Text(fState.feedModel.feeds[index].body),
            //     ),
            //   ),
            // );
          },
          itemCount: fState.feedModel.feeds.length,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
        );
      }
      if (fState.feedModel != null && fState.feedModel.feeds.length == 0) {
        return Center(
          child: Text("Feed list is empty."),
        );
      }
      if (fState.feedModel == null) {
        return Center(
          child: Text("Unable to fetch Feed"),
        );
      }
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  // }

  FeedState gloablFeedstate;

  @override
  Widget build(BuildContext context) {
    return
        // MultiProvider(
        //   providers: [
        //     Provider<FeedState>.value(value: FeedState()),
        //     Provider<ScheduleState>.value(value: ScheduleState()),
        //   ],
        ChangeNotifierProvider<FeedState>(
      builder: (_) {
        FeedState feedstate = FeedState();
        feedstate.fetchList();
        gloablFeedstate = feedstate;
        return feedstate;
      },
      child: ChangeNotifierProvider<ScheduleState>(
        builder: (_) {
          ScheduleState scheduleState = ScheduleState();
          return scheduleState;
        },
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          drawer: _buildDrawerContent(context),
          appBar: WhiteAppBar(
            centerTitle: true,
            title: SmallAppLogo(),
            leading: IconButton(
              icon: ImageIcon(
                AssetImage("images/menu32.png"),
                color: Palette.appBlack,
                size: 16.0,
              ),
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
            ),
            actions: <Widget>[],
          ),
          body: Consumer<FeedState>(
            builder: (context, fState, child) {
              if (fState.bottomBarIndex == 0) {
                return RefreshIndicator(
                  child: _buildFeedList(),
                  onRefresh: () async {
                    await fState.fetchList();
                    return;
                  },
                );
              } else {
                return ScheduleWidget();
              }
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Consumer<FeedState>(
            builder: (context, fState, child) {
              return BottomNavigationBar(
                backgroundColor: Colors.white,
                currentIndex: fState.bottomBarIndex,
                onTap: (index) {
                  fState.setBottomBarIndex(index);
                },
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    title: Text("Home"),
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage("images/schedule.png"),
                      size: 16.0,
                    ),
                    title: Text("Schedule"),
                  ),
                ],
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Colors.blue,
            onPressed: () {
              _showFeedPostPopup(context);
              // WidgetUtils.showAddFeedPage(context);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCardPost(BuildContext context, Feeds feed) {
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
            elevation: 0.0,
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
                              backgroundImage: AdvancedNetworkImage(
                                "${ConstUtils.baseUrlNoSlash}${feed.userPic}",
                                useDiskCache: true,
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
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                          bottom: 4.0,
                          top: 4.0,
                        ),
                        child: Text(
                          feed.body,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
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
                                        "${ConstUtils.baseUrlNoSlash}${feed.iamge}",
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
