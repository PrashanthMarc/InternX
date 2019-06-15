import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swecha/pages/schedule/schedule_widget.dart';
import 'package:swecha/pages/schedule/state/schedulestate.dart';
import 'package:swecha/widgets/full_app_logo.dart';
import 'package:swecha/widgets/white_app_bar.dart';

class SchedulePage extends StatefulWidget {
  static String TAG = "SchedulePage";
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "SchedulePage");
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ScheduleState>(
      builder: (_) {
        ScheduleState schedulestate = ScheduleState();
        // schedulestate.fetchSchedule();
        return schedulestate;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: WhiteAppBar(
          title: Text("Schedule",
          style: TextStyle(
            color: Colors.green,
            fontSize: 24.0,
            fontFamily: "Nunito",
          ),),
          centerTitle: true,
        ),
        body: ScheduleWidget(),
      ),
    );
  }
}
