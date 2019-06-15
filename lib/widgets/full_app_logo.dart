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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "images/logo.png",
                height: 300.0,
              ),
              SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}

class SmallLogo extends StatelessWidget {
  static const String TAG = "SIZED_FULL_LOGO";

  double size = 30.0;

  SmallLogo({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textScaleFactor: 1.0,
      text: new TextSpan(
        children: <TextSpan>[
          new TextSpan(
            text: 'intern',
            style: TextStyle(
              fontSize: size,
              fontFamily: "Nunito",
              color: Colors.blue,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: 'X',
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
