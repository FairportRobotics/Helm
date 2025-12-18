import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:helm/ntutils.dart';
import 'package:helm/widgets/base_card.dart';
import 'package:nt4/nt4.dart';

class PostySummaryCard extends StatefulWidget {
  const PostySummaryCard({super.key});

  @override
  State<StatefulWidget> createState() => _PostySummaryCardState();
}

class _PostySummaryCardState extends State<PostySummaryCard> {
  final String _ntTopic = "/Posty/results/post/resultsJson";

  List<PostyResultModel> resultsData = [];

  _PostySummaryCardState() {}

  @override
  Widget build(BuildContext context) {
    NT4Subscription sub = NTUtils().subscribe(_ntTopic);
    sub.listen((data) {
      setState(() {
        List<dynamic> tmp = jsonDecode(data.toString());

        for (dynamic json in tmp) {
          resultsData.add(PostyResultModel.fromJson(json));
        }
      });
    });

    bool systemNotReady = false;

    for (PostyResultModel result in resultsData) {
      systemNotReady |= result.result == "FAILED";
    }

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
                color: !systemNotReady ? Colors.green : Colors.red,
              ),
            ),
          ),
        ),
      ),
    ];
    return BaseCard(
      width: 1,
      height: 1,
      cardTitle: "System Status",
      children: children,
    );
  }
}

class PostyResultModel {
  String testName = "";
  String subsystemName = "";
  String result = "";
  String failReason = "";

  PostyResultModel(
    this.testName,
    this.subsystemName,
    this.result,
    this.failReason,
  );

  PostyResultModel.fromJson(Map<String, dynamic> json)
    : testName = json['testName'] as String,
      subsystemName = json['subsystemName'] as String,
      result = json['result'] as String,
      failReason = json['failReason'] as String;
}
