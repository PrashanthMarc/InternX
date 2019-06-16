import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swecha/misc/widget_utils.dart';
import 'package:swecha/pages/schedule/model/schedulemodel.dart';
import 'package:swecha/pages/schedule/state/schedulestate.dart';

class ScheduleWidget extends StatefulWidget {
  @override
  _ScheduleWidgetState createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  ScheduleState scheduleState;

  _buildScheduleList() {
    return Consumer<ScheduleState>(builder: (context, fState, child) {
      if (fState.tokenError) {
        WidgetUtils.proceedToAuth(context, replaceAll: true);
      }
      if (fState.isFetching) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (!fState.isFetching && fState.errorCode == 401) {
        WidgetUtils.proceedToAuth(context);
      }
      if (fState.listScheduleModel != null &&
          fState.listScheduleModel.length > 0) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                  top: 4.0, left: 8.0, right: 8.0, bottom: 4.0),
              child: ExpansionTile(
                key: PageStorageKey<ScheduleModel>(
                    fState.listScheduleModel[index]),
                title: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 16.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Day ${fState.listScheduleModel[index].day}",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          // Text(
                          //   fState..toString(),
                          //   style: TextStyle(
                          //     fontSize: 24.0,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Text(fState.listScheduleModel[index].title +
                        " ${fState.listScheduleModel[index].assigments.length > 0 ? '*' : ''}")
                  ],
                ),
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: "Location: ",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      "${fState.listScheduleModel[index].location}",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            if (fState.listScheduleModel[index].assigments
                                    .length >
                                0)
                              OutlineButton(
                                highlightColor: Colors.blue,
                                child: Text("Assignment"),
                                onPressed: () {
                                  WidgetUtils.showAssignmentPage(
                                    context,
                                    "Assignment",
                                    fState.listScheduleModel[index]
                                        .assigments[0].body,
                                  );
                                },
                              ),
                            OutlineButton(
                              highlightColor: Colors.blue,
                              child: Text("Feedback"),
                              onPressed: () {
                                // WidgetUtils.showAssignmentPage(
                                //   context,
                                //   "Feedback",
                                //   fState.listScheduleModel[index].assigments[0]
                                //       .body,
                                // );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              // Card(
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Text(fState.listScheduleModel[index].title),
              //   ),
              // ),
            );
          },
          itemCount: fState.listScheduleModel.length,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
        );
      }
      if (fState.listScheduleModel != null &&
          fState.listScheduleModel.length == 0) {
        return Center(
          child: Text("Schedule is empty."),
        );
      }
      if (fState.listScheduleModel == null) {
        return Center(
          child: Text("Unable to fetch Schedule"),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    scheduleState = Provider.of<ScheduleState>(context);
    return _buildScheduleList();
  }
}
