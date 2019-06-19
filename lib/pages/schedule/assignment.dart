import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:swecha/widgets/white_app_bar.dart';

class AssignmentPage extends StatefulWidget {
  static String TAG = "ASSIGNMENT_PAGE";

  final String title;
  final String data;

  AssignmentPage({@required this.title, @required this.data});

  @override
  _AssignmentPageState createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  @override
  Widget build(BuildContext context) {
    String data = widget.data.replaceAll("/media", "http://internx.xyz/media") +
        "<style>img {width: 100%  !important;}</style>";
    data = data.replaceAll("src=\"//", "src=\"https://");
    print(data);
    return WebviewScaffold(
      url: Uri.dataFromString(utf8.decode(data.codeUnits),
              mimeType: 'text/html', encoding: utf8)
          .toString(),
      appBar: WhiteAppBar(
        title: Text("${widget.title}"),
      ),
      withZoom: true,
      withJavascript: true,
      withLocalStorage: true,
      hidden: true,
      initialChild: Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
    // return Scaffold(
    // appBar: WhiteAppBar(
    //   title: Text("${widget.title}"),
    // ),
    //   body: Container(
    //     width: MediaQuery.of(context).size.width,
    //     height: MediaQuery.of(context).size.height,
    //     child: WebView(
    //       javascriptMode: JavascriptMode.unrestricted,
    //       initialUrl:
    //           Uri.dataFromString(data, mimeType: 'text/html').toString(),
    //     ),
    //   ),
    // );
  }
}
