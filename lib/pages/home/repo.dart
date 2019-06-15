import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swecha/widgets/white_app_bar.dart';

class RepoPage extends StatefulWidget {
  @override
  _RepoPageState createState() => _RepoPageState();
}

class _RepoPageState extends State<RepoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WhiteAppBar(
        backgroundColor: Colors.white,
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
    );
  }
}
