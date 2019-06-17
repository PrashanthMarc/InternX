import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swecha/pages/news/news_widget.dart';
import 'package:swecha/pages/news/state/newsstate.dart';
import 'package:swecha/pages/repos/repo_widget.dart';
import 'package:swecha/pages/repos/state/repostate.dart';
import 'package:swecha/widgets/white_app_bar.dart';

class NewsPage extends StatefulWidget {
  static String TAG = "NewsPage";
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "NewsPage");
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewsState>(
      builder: (_) {
        NewsState repostate = NewsState();
        return repostate;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: WhiteAppBar(
          title: Text(
            "News",
            style: TextStyle(
              color: Colors.green,
              fontSize: 24.0,
              fontFamily: "Nunito",
            ),
          ),
          centerTitle: true,
        ),
        body: NewsWidget(),
      ),
    );
  }
}
