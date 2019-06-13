import 'package:flutter/material.dart';
import 'package:swecha/widgets/white_app_bar.dart';
import 'package:swecha/misc/widget_utils.dart';

class RequestMentorPage extends StatefulWidget {

  static String TAG = "REQUEST MENTOR";
  @override
  _RequestMentorPageState createState() => _RequestMentorPageState();
}

class _RequestMentorPageState extends State<RequestMentorPage> {

  TextEditingController _rollnumberController = TextEditingController();
  TextEditingController _trackController = TextEditingController();
  TextEditingController _batchnumberController = TextEditingController();
  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WhiteAppBar(
        title: Text("Request A Mentor"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: TextField(
                maxLength: 32,
                textCapitalization: TextCapitalization.words,
                controller: _rollnumberController,
                decoration: InputDecoration(
                  labelText: "Your Roll Number*",
                  hintText: "10256",
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: TextField(
                maxLength: 32,
                textCapitalization: TextCapitalization.words,
                controller: _trackController,
                decoration: InputDecoration(
                  labelText: "Track*",
                  hintText: "eg: Python",
                ),
                keyboardType: TextInputType.text,
                // textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: TextField(
                controller: _batchnumberController,
                decoration: InputDecoration(
                    labelText: "Batch Number*", hintText: "eg: 5"),
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 16.0),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                    labelText: "Notes",
                    hintText: "eg: I need explanation for python classes"),
                maxLength: 10,
                keyboardType: TextInputType.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
