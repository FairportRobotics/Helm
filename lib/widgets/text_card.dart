import 'package:flutter/material.dart';
import './base_card.dart';

class TextCard extends StatefulWidget {
  const TextCard({
    super.key,
    required this.cardTitle,
    this.ntTopic,
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
  @override
  Widget build(BuildContext context) {
    return BaseCard(
      cardTitle: widget.cardTitle,
      width: widget.width,
      height: widget.height,
      children: [
        Text("WAHOOOO")
      ],
    );
  }
}
