import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swecha/misc/widget_utils.dart';
import 'package:swecha/pages/repos/model/repomodel.dart';
import 'package:swecha/pages/repos/state/repostate.dart';

class RepoWidget extends StatefulWidget {
  @override
  _RepoWidgetState createState() => _RepoWidgetState();
}

class _RepoWidgetState extends State<RepoWidget> {
  RepoState repoState;

  _buildRepoList() {
    return Consumer<RepoState>(builder: (context, fState, child) {
      if (fState.isFetching) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (!fState.isFetching && fState.errorCode == 401) {
        WidgetUtils.proceedToAuth(context);
      }
      if (fState.repoModel != null && fState.repoModel.results.length > 0) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                  top: 4.0, left: 8.0, right: 8.0, bottom: 4.0),
              child: ListTile(
                title: Text(fState.repoModel.results[index].title),
                trailing: Icon(
                  Icons.chevron_right,
                ),
                onTap: () {
                  WidgetUtils.showAssignmentPage(
                      context,
                      fState.repoModel.results[index].title,
                      fState.repoModel.results[index].body);
                },
              ),
            );
          },
          itemCount: fState.repoModel.results.length,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
        );
      }
      if (fState.repoModel != null && fState.repoModel.results.length == 0) {
        return Center(
          child: Text("No Repos yet."),
        );
      }
      if (fState.repoModel == null) {
        return Center(
          child: Text("Loading..."),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    repoState = Provider.of<RepoState>(context);
    return _buildRepoList();
  }
}
