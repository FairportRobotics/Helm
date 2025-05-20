import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget {
  const BaseCard({
    super.key,
    required this.cardTitle,
    this.children = const [],
    this.height = 1,
    this.width = 1,
  });

  final List<Widget> children;

  final String cardTitle;

  final int width, height;

  @override
  Widget build(BuildContext context) {

    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: SizedBox(
          width: 100.0 * width,
          height: 100.0 * height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(cardTitle),
              SizedBox(width: 100, height: 10),
            ] + children,
          ),
        ),
      ),
    );
  }
}
