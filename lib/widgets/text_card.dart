import 'package:flutter/material.dart';
import './base_card.dart';
import 'package:nt4/nt4.dart';
import 'package:helm/ntutils.dart';

class TextCard extends StatefulWidget {
  TextCard({
    super.key,
    required this.cardTitle,
    this.ntTopic = "",
    this.height = 1,
    this.width = 1,
  });

  final String cardTitle;
  String ntTopic = "";

  final int width, height;

  @override
  State<TextCard> createState() => _TextCardState();
}

class _TextCardState extends State<TextCard> {
  String _val = "";

  _TextCardState() {}

  void setVal(String newVal) {
    setState(() {
      _val = newVal;
    });
  }

  @override
  Widget build(BuildContext context) {
    NT4Subscription sub = NTUtils().subscribe(widget.ntTopic);
    sub.listen((data) => setVal(data.toString()));
    return BaseCard(
      cardTitle: widget.cardTitle,
      width: widget.width,
      height: widget.height,
      children: [Text(_val)],
    );
  }
}
