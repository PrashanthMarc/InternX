import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swecha/pages/repos/repo_widget.dart';
import 'package:swecha/pages/repos/state/repostate.dart';
import 'package:swecha/widgets/white_app_bar.dart';

class RepoPage extends StatefulWidget {
  static String TAG = "RepoPage";
  @override
  _RepoPageState createState() => _RepoPageState();
}

class _RepoPageState extends State<RepoPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "RepoPage");
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RepoState>(
      builder: (_) {
        RepoState repostate = RepoState();
        return repostate;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: WhiteAppBar(
          title: Text(
            "Repos",
            style: TextStyle(
              color: Colors.green,
              fontSize: 24.0,
              fontFamily: "Nunito",
            ),
          ),
          centerTitle: true,
        ),
        body: RepoWidget(),
      ),
    );
  }
}
