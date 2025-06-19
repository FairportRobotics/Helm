import 'package:flutter/material.dart';
import './base_card.dart';
import 'package:nt4/nt4.dart';
import '../globals.dart' as glob;

class TextCard extends StatefulWidget {
  const TextCard({
    super.key,
    required this.cardTitle,
    this.ntTopic = '',
    this.height = 1,
    this.width = 1,
  });

  final String cardTitle;
  final String? ntTopic;

  final int width, height;

  @override
  State<TextCard> createState() => _TextCardState();
}

class _TextCardState extends State<TextCard> {
  String _val = "";

  void setVal( String newVal )
  {
    _val = newVal;
  }

  @override
  Widget build(BuildContext context) {
    NT4Subscription sub = glob.subscribe(widget.ntTopic!);
    sub.listen( (data) => setVal(data.toString()) );

    return BaseCard(
      cardTitle: widget.cardTitle,
      width: widget.width,
      height: widget.height,
      children: [
        Text(_val)
      ],
    );
  }
}
