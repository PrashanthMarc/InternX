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
            print(fState.listScheduleModel[index].toJson());
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
                            fState.listScheduleModel[index].day.toString(),
                            style: TextStyle(
                              fontSize: 24.0,
                            ),
                          ),
                          Text(
                            "Day",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(fState.listScheduleModel[index].title)
                  ],
                ),
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Location: ${fState.listScheduleModel[index].location}",
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          "Assignments",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Column(
                          children: <Widget>[
                            for (int i = 0;
                                i <
                                    fState.listScheduleModel[index].assigments
                                        .length;
                                i++)
                              ListTile(
                                title: Text(
                                    "Assignment ${fState.listScheduleModel[index].assigments[index].no}"),
                                trailing: Icon(Icons.chevron_right),
                                onTap: () {
                                  WidgetUtils.showAssignmentPage(context, fState.listScheduleModel[index].assigments[index].no, fState.listScheduleModel[index].assigments[index].body,);
                                },
                              ),
                          ],
                        )
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
          child: Text("Unable to fetch Schedule"),
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
