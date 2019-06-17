import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swecha/misc/widget_utils.dart';
import 'package:swecha/pages/news/state/newsstate.dart';

class NewsWidget extends StatefulWidget {
  @override
  _NewsWidgetState createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  NewsState repoState;

  _buildNewsList() {
    return Consumer<NewsState>(builder: (context, fState, child) {
      if (fState.isFetching) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (!fState.isFetching && fState.errorCode == 401) {
        WidgetUtils.proceedToAuth(context);
      }
      if (fState.newsModel != null && fState.newsModel.results.length > 0) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                  top: 4.0, left: 8.0, right: 8.0, bottom: 4.0),
              child: ListTile(
                title: Text(fState.newsModel.results[index].title),
                trailing: Icon(
                  Icons.chevron_right,
                ),
                onTap: () {
                  WidgetUtils.showAssignmentPage(
                      context,
                      fState.newsModel.results[index].title,
                      fState.newsModel.results[index].body);
                },
              ),
            );
          },
          itemCount: fState.newsModel.results.length,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
        );
      }
      if (fState.newsModel != null && fState.newsModel.results.length == 0) {
        return Center(
          child: Text("No Newss yet."),
        );
      }
      if (fState.newsModel == null) {
        return Center(
          child: Text("Loading..."),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    repoState = Provider.of<NewsState>(context);
    return _buildNewsList();
  }
}
