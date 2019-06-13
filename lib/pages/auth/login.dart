import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class LogInPage extends StatefulWidget {
  static String TAG = "LOGIN";

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  TapGestureRecognizer _tapGestureRecognizer;
  TextEditingController _smsController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  final hintStyle = TextStyle(color: Colors.white24);

  // bool isSmsSent = false;
  // bool isCodeVerify = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 10.0,
              left: 20.0,
              child: Text(
                "SwechaInternX",
                style: TextStyle(
                  fontSize: 34.0,
                  fontFamily: "Roboto",
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            
      ),],),),);
  }
}
