import 'dart:convert';

import 'package:helm/widgets/posty/models/posty_results_model.dart';

import 'package:flutter/material.dart';
import 'package:helm/ntutils.dart';
import 'package:helm/widgets/base_card.dart';
import 'package:nt4/nt4.dart';

class PostySummaryCard extends StatefulWidget {
  const PostySummaryCard({super.key, this.showAlertDialog = false});

  final bool showAlertDialog;

  @override
  State<StatefulWidget> createState() => _PostySummaryCardState();
}

class _PostySummaryCardState extends State<PostySummaryCard> {
  final String _ntTopic = "/Posty/results/post/resultsJson";
  NT4Subscription? sub;
  List<PostyResultModel> resultsData = [];

  @override
  void initState() {
    super.initState();
    sub = NTUtils().subscribe(_ntTopic);
    sub!.listen((data) {
      setState(() {
        List<dynamic> tmp = jsonDecode(data.toString());

        resultsData.clear();
        for (dynamic json in tmp) {
          resultsData.add(PostyResultModel.fromJson(json));
        }
      });
    });
  }

  bool isFailedResult() {
    bool systemNotReady = false;

    for (PostyResultModel result in resultsData) {
      systemNotReady |= result.result == "FAILED";
    }

    return systemNotReady;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Center(
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
          child: Padding(
            padding: EdgeInsets.all(2),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: !isFailedResult() ? Colors.green : Colors.red,
              ),
            ),
          ),
        ),
      ),
    ];

    if (isFailedResult()) {
      if (widget.showAlertDialog) {
        WidgetsBinding.instance.addPostFrameCallback((dur) {
          showDialog<String>(
            context: context,
            builder:
                (BuildContext context) => AlertDialog(
                  title: const Text("POST Test failed"),
                  content: Text("Hello World"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => {Navigator.pop(context, 'Ignore')},
                      child: const Text("Ignore"),
                    ),
                    TextButton(
                      onPressed: () => {Navigator.pop(context, 'Re-run test')},
                      child: const Text("Re-run test"),
                    ),
                  ],
                ),
          );
        });
      }
    }

    return BaseCard(
      width: 1,
      height: 1,
      cardTitle: "System Status",
      children: children,
    );
  }
}
