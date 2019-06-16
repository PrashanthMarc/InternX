import 'package:flutter/material.dart';
// import 'package:swecha/widgets/slogan_widget.dart';

class FullAppLogo extends StatelessWidget {
  static const String TAG = "FULL_LOGO";

  final bool showTitle;

  const FullAppLogo({Key key, this.showTitle = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: TAG,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "images/app_logo_splash.png",
                  height: 300.0,
                ),
                SizedBox(height: 8.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SmallAppLogo extends StatelessWidget {
  static const String TAG = "SIZED_FULL_LOGO";

  double size = 30.0;

  SmallAppLogo({Key key, this.size = 24.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Swecha',
            style: TextStyle(
              fontSize: size,
              fontFamily: "Nunito",
              color: Colors.blue,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: 'InternX',
            style: TextStyle(
              fontSize: size,
              fontFamily: "Nunito",
              color: Colors.green,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
