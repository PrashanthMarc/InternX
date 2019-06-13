import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swecha/misc/palette.dart';
import 'package:swecha/misc/widget_utils.dart';
import 'package:swecha/pages/auth/state/loginstate.dart';
import 'package:swecha/widgets/white_app_bar.dart';

class LogInPage extends StatefulWidget {
  static String TAG = "LOGIN";

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  // TapGestureRecognizer _tapGestureRecognizer;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final hintStyle = TextStyle(color: Colors.white24);

  // bool isSmsSent = false;
  // bool isCodeVerify = false;

  var loginState;

  void _showSnackBar(String msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  void _performLogin() async {
    if (_usernameController.text.isEmpty) {
      _showSnackBar("Username cannot be empty");
      return;
    }
    if (_passwordController.text.isEmpty) {
      _showSnackBar("Password cannot be empty");
      return;
    }

    await loginState.loginUser(
        _usernameController.text, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    loginState = Provider.of<LoginState>(context);

    return ChangeNotifierProvider<LoginState>(
      builder: (_) => LoginState(),
      child: Scaffold(
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
                child: RichText(
                  text: new TextSpan(
                    style: new TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      new TextSpan(
                        text: 'Swecha',
                        style: TextStyle(
                          fontSize: 44.0,
                          fontFamily: "Nunito",
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: 'InternX',
                        style: TextStyle(
                          fontSize: 44.0,
                          fontFamily: "Nunito",
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
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
                              enabled: !loginState.isFetching,
                              controller: _usernameController,
                              onSubmitted: (value) {},
                              decoration: InputDecoration.collapsed(
                                hintText: "Username",
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: "Nunito",
                                color: Color(0xFF000000),
                                // fontWeight: FontWeight.bold,
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
                              enabled: !loginState.isFetching,
                              controller: _passwordController,
                              onSubmitted: (value) {},
                              decoration: InputDecoration.collapsed(
                                hintText: "Password",
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
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 14.0, bottom: 14.0),
                          child: loginState.isFetching
                              ? CircularProgressIndicator()
                              : Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color(0xFFFFFFFF),
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                        ),
                        color: Colors.blue,
                        onPressed: loginState.isFetching
                            ? null
                            : () {
                                _performLogin();
                                // WidgetUtils.showMoreInfoPage(
                                //   context,
                                // );
                              },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
