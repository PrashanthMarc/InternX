import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:swecha/misc/widget_utils.dart';
import 'package:swecha/pages/requestmentor/model/mentor_model.dart';
import 'package:swecha/pages/requestmentor/state/mentor_state.dart';

class MentorWidget extends StatefulWidget {
  @override
  _MentorWidgetState createState() => _MentorWidgetState();
}

class _MentorWidgetState extends State<MentorWidget> {
  MentorState mentorState;

  TextEditingController _queryController = TextEditingController();

  _buildMentorList() {
    return Consumer<MentorState>(builder: (context, fState, child) {
      if (fState.isFetching) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (!fState.isFetching && fState.errorCode == 401) {
        WidgetUtils.proceedToAuth(context);
      }
      if (fState.mentorModel != null && fState.mentorModel.results.length > 0) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                  top: 4.0, left: 8.0, right: 8.0, bottom: 4.0),
              child: ListTile(
                title: Text(
                  fState.mentorModel.results[index].body,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.check,
                  ),
                  onPressed: () {},
                ),
              ),
            );
          },
          itemCount: fState.mentorModel.results.length,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
        );
      }
      if (fState.mentorModel != null &&
          fState.mentorModel.results.length == 0) {
        return Center(
          child: Text("No Queries yet."),
        );
      }
      if (fState.mentorModel == null) {
        return Center(
          child: Text("Loading..."),
        );
      }
    });
  }

  _postQuery() async {
    if (_queryController.text.trim().isEmpty) {
      Fluttertoast.showToast(
          msg: "Query cannot be empty.",
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIos: 1);
    }
    await mentorState.postQuery(_queryController.text);
  }

  @override
  Widget build(BuildContext context) {
    mentorState = Provider.of<MentorState>(context);
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _queryController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                    hintText: "Have a query?",
                    labelText: "Query",
                    suffixIcon: mentorState.isQueryPosting
                        ? SizedBox(
                            height: 10.0,
                            width: 10.0,
                            child: CircularProgressIndicator(),
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.send,
                            ),
                            onPressed: () {
                              _postQuery();
                            },
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: _buildMentorList(),
        ),
      ],
    );
  }
}
