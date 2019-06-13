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
_showAddReviewPopup() {
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
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          top: 16.0, bottom: 8.0, left: 16.0, right: 16.0),
                      child: Text(
                        "Review",
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
          _buildFeedPost();
        },
      ),
    );
  }
}

// class FeedPage extends StatefulWidget {
//   static String get TAG => null;
//   // static String TAG = "DISCOVER";

//   static String picture;

//   @override
//   _FeedPageState createState() => _FeedPageState();
// }

// class _FeedPageState extends State<FeedPage>

//     with TickerProviderStateMixin {
//   final GlobalKey<ScaffoldState> _scaffoldKey =
//       GlobalKey<ScaffoldState>(debugLabel: "discover_page");

//   TabController _tabController;
//   TextEditingController _restaurantFinder = TextEditingController();
//   TextEditingController _dishFinder = TextEditingController();

//   _buildBottomContent() {
//     return Container(
//       padding: const EdgeInsets.only(
//         left: 16.0,
//         right: 16.0,
//       ),
//       child: Column(
//         children: <Widget>[
//           Divider(),
//           ListTile(
//             trailing: ImageIcon(
//               AssetImage(
//                 "images/restaurant_finder.png",
//               ),
//               color: Palette.imageBlack,
//               size: 28.0,
//             ),
//             title: new TextField(
//               controller: _restaurantFinder,
//               decoration: InputDecoration.collapsed(
//                 hintText: 'Restaurant Finder',
//                 hintStyle: TextStyle(
//                   fontSize: 16.0,
//                 ),
//               ),
//             ),
//             onTap: () {
//               // WidgetUtils.showFeedPage(context);
//             },
//           ),
//           Divider(),
//           ListTile(
//             trailing: ImageIcon(
//               AssetImage(
//                 "images/search32.png",
//               ),
//               color: Palette.imageBlack,
//               size: 16.0,
//             ),
//             title: new TextField(
//               controller: _dishFinder,
//               decoration: InputDecoration.collapsed(
//                 hintText: 'Dish Finder',
//                 hintStyle: TextStyle(
//                   fontSize: 16.0,
//                 ),
//               ),
//             ),
//             onTap: () {
//               // WidgetUtils.showFeedPage(context);
//             },
//           ),
//           Divider(),
//           SizedBox(
//             height: 16.0,
//           ),
//         ],
//       ),
//     );
//   }

//   // _buildSubmitButton() {
// //    return Container(
// //      width: MediaQuery.of(context).size.width,
// //      child: RawMaterialButton(
// //        fillColor: Palette.appBlack,
// //        onPressed: () {
// //          Navigator.of(context).pop();
// //        },
// //        padding: const EdgeInsets.all(16.0),
// //        child: Text(
// //          "SUBMIT",
// //          style: TextStyle(color: Colors.white, fontFamily: "RobotoSlab"),
// //        ),
// //      ),
// //    );
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.only(
//               top: 0.0,
//               bottom: 20.0,
//             ),
//             child: SizedBox(
//               width: MediaQuery.of(context).size.width * 0.7,
//               child: RaisedButton(
//                 color: Palette.appBlack,
//                 shape: new RoundedRectangleBorder(
//                     borderRadius: new BorderRadius.circular(30.0)),
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
//                   child: Text(
//                     "SUBMIT",
//                     style: TextStyle(
//                         fontSize: 14.0,
//                         color: Colors.white,
//                         fontFamily: "RobotoSlab"),
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   WhiteAppBar _buildAppBar(BuildContext context) {
//     return WhiteAppBar(
//       centerTitle: true,
//       title: Text(
//         "Home",
//         style: TextStyle(
//           fontSize: 21.0,
//         ),
//       ),
//       leading: IconButton(
//         icon: ImageIcon(
//           AssetImage("images/menu32.png"),
//           color: Palette.lightGrey,
//           size: 16.0,
//         ),
//         onPressed: () {
//           _scaffoldKey.currentState.openDrawer();
//         },
//       ),
//       actions: <Widget>[
//         Padding(
//           padding: const EdgeInsets.only(right: 16.0),
//           child: IconButton(
//             icon: ImageIcon(AssetImage("images/camera.png")),
//             iconSize: 16.0,
//             color: Palette.lightGrey,
//             onPressed: () async {
//               _openImagePicker();
//               // try {
//               //   cameras = await availableCameras();
//               // } on CameraException catch (e) {
//               //   logError(e.code, e.description);
//               // }
//               // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//               //   return CameraCustom(cameras);
//               // }));
//             },
//           ),
//         )
//       ],
//     );
//     _buildDrawerContent(BuildContext context) {
//       return DrawerWidget();
//     }
//   }
// }
