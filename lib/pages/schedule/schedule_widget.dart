import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swecha/misc/widget_utils.dart';
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
            return Padding(
              padding: const EdgeInsets.only(
                  top: 4.0, left: 8.0, right: 8.0, bottom: 4.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(fState.listScheduleModel[index].title),
                ),
              ),
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
