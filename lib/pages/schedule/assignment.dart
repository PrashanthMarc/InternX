import 'package:flutter/material.dart';
import 'package:swecha/widgets/white_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AssignmentPage extends StatefulWidget {
  static String TAG = "ASSIGNMENT_PAGE";

  final int no;
  final String data;

  AssignmentPage({@required this.no, @required this.data});

  @override
  _AssignmentPageState createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WhiteAppBar(
        title: Text("Assignment ${widget.no}"),
      ),
      body: WebView(
        initialUrl:
            Uri.dataFromString(widget.data, mimeType: 'text/html').toString(),
      ),
    );
  }
}
