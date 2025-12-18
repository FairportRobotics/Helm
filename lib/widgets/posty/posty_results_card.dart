import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:helm/ntutils.dart';
import 'package:helm/widgets/base_card.dart';
import 'package:nt4/nt4.dart';

class PostyResultsCard extends StatefulWidget {
  const PostyResultsCard({super.key});

  @override
  State<StatefulWidget> createState() => _PostyResultsCardState();
}

class _PostyResultsCardState extends State<PostyResultsCard> {
  final String _ntTopic = "/Posty/results/post/resultsJson";

  List<PostyResultModel> resultsData = [];

  _PostyResultsCardState() {
    NT4Subscription sub = NTUtils().subscribe(_ntTopic);
    sub.listen((data) {
      setState(() {
        List<dynamic> tmp = jsonDecode(data.toString());

        for (dynamic json in tmp) {
          resultsData.add(PostyResultModel.fromJson(json));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    resultsData.sort((a, b) => a.subsystemName.compareTo(b.subsystemName));

    children =
        resultsData.map((result) {
          Color statusColor = Colors.green;
          if (result.result == "FAILED") {
            statusColor = Colors.red;
          } else if (result.result == "SKIPPED") {
            statusColor = Colors.grey;
          }

          return Text(
            "${result.testName} -- ${result.result}",
            style: TextStyle(color: statusColor),
          );
        }).toList();

    return BaseCard(
      width: 6,
      height: 2,
      cardTitle: "Self Test Results",
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
