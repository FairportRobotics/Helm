import 'dart:convert';

import 'package:helm/widgets/posty/models/posty_results_model.dart';

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
  NT4Subscription? sub;
  List<PostyResultModel> resultsData = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Dispose");
    NTUtils().unsubscribe(sub!);
  }

  @override
  void initState() {
    super.initState();
    print("It's been made");
    sub = NTUtils().subscribe(
      _ntTopic,
      opts: NT4SubscriptionOptions(all: true),
    );
    sub!.listen((data) {
      print("nt Update");
      setState(() {
        List<dynamic> tmp = jsonDecode(data.toString());

        resultsData.clear();
        for (dynamic json in tmp) {
          resultsData.add(PostyResultModel.fromJson(json));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Build");
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
