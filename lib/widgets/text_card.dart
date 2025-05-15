import 'package:flutter/material.dart';

class TextCard extends StatefulWidget {
  const TextCard({super.key, required this.cardTitle});

  final String cardTitle;

  @override
  State<TextCard> createState() => _TextCardState();
}

class _TextCardState extends State<TextCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(widget.cardTitle),
            SizedBox(width: 100, height: 10),
            Text("THE COOL TEXT"),
          ],
        ),
      ),
    );
  }
}
