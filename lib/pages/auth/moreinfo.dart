import 'package:flutter/material.dart';
import 'package:swecha/misc/palette.dart';
import 'package:swecha/misc/widget_utils.dart';
import 'package:swecha/widgets/white_app_bar.dart';

class MoreInfoPage extends StatefulWidget {
  static String TAG = "LOGIN";

  @override
  _MoreInfoPageState createState() => _MoreInfoPageState();
}

class _MoreInfoPageState extends State<MoreInfoPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  // TapGestureRecognizer _tapGestureRecognizer;
  TextEditingController _nameController = TextEditingController();
  // TextEditingController _phoneNumberController = TextEditingController();

  final hintStyle = TextStyle(color: Colors.white24);

  // bool isSmsSent = false;
  // bool isCodeVerify = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: WhiteAppBar(),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 10.0,
              left: 20.0,
              child: Text(
                "More About Me",
                style: TextStyle(
                  fontSize: 34.0,
                  fontFamily: "Nunito",
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      bottom: 5.0,
                    ),
                    color: Colors.white,
                    child: Opacity(
                      opacity: 0.5,
                      child: Card(
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            onSubmitted: (value) {},
                            decoration: InputDecoration.collapsed(
                              hintText: "First Name",
                              filled: true,
                              fillColor: Colors.white,
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "Nunito",
                              color: Color(0xFF000000),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      bottom: 5.0,
                    ),
                    color: Colors.white,
                    child: Opacity(
                      opacity: 0.5,
                      child: Card(
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            onSubmitted: (value) {},
                            decoration: InputDecoration.collapsed(
                              hintText: "Last Name",
                              filled: true,
                              fillColor: Colors.white,
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "Nunito",
                              color: Color(0xFF000000),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      bottom: 8.0,
                    ),
                    color: Colors.white,
                    child: Opacity(
                      opacity: 0.5,
                      child: Card(
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            onSubmitted: (value) {},
                            decoration: InputDecoration.collapsed(
                              hintText: "Phone", //unique
                              filled: true,
                              fillColor: Colors.white,
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "Nunito",
                              color: Color(0xFF000000),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 14.0,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: RaisedButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
                        child: Text(
                          "Let me In", //I'm In
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Color(0xFFFFFFFF),
                              fontFamily: "Nunito"),
                        ),
                      ),
                      color: Colors.blue,
                      onPressed: () {
                        WidgetUtils.showFeedPage(
                          context,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
