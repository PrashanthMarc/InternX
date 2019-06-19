import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swecha/pages/requestmentor/mentor_widget.dart';
import 'package:swecha/pages/requestmentor/state/mentor_state.dart';
import 'package:swecha/widgets/white_app_bar.dart';

class MentorPage extends StatefulWidget {
  static String TAG = "MentorPage";
  @override
  _MentorPageState createState() => _MentorPageState();
}

class _MentorPageState extends State<MentorPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "MentorPage");
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MentorState>(
      builder: (_) {
        MentorState repostate = MentorState();
        return repostate;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: WhiteAppBar(
          title: Text(
            "Request a Mentor",
            style: TextStyle(
              color: Colors.green,
              fontSize: 24.0,
              fontFamily: "Nunito",
            ),
          ),
          centerTitle: true,
        ),
        body: MentorWidget(),
      ),
    );
  }
}
