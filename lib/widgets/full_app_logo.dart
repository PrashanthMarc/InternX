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
                "images/hmlogotext300.png",
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

class SizedAppLogo extends StatelessWidget {
  static const String TAG = "SIZED_FULL_LOGO";

  final bool showTitle;
  double size = 100.0;

  SizedAppLogo({Key key, this.showTitle = true, this.size}) : super(key: key);

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
              SizedBox(
                  height: 100.0,
                  child: Image.asset(
                    "images/hmlogotext300.png",
                  )),
              SizedBox(height: 8.0),
            
            ],
          ),
        ),
      ),
    );
  }
}
