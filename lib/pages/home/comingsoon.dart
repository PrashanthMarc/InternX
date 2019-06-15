import 'package:flutter/material.dart';
import 'package:swecha/widgets/full_app_logo.dart';
import 'package:swecha/widgets/white_app_bar.dart';

class ComingSoonPage extends StatefulWidget {
  static String TAG = "COMINGSOON";
  @override
  _ComingSoonPageState createState() => _ComingSoonPageState();
}

class _ComingSoonPageState extends State<ComingSoonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WhiteAppBar(
        title: SmallAppLogo(),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage(
              "images/logo.png",
            ),
            height: 120.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Text(
              "Welcome to Swecha Internship Program - 2019",
              style: TextStyle(
                color: Colors.green,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
