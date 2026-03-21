import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:helm/ntutils.dart';
import 'package:helm/widgets/base_card.dart';
import 'package:nt4/nt4.dart';

class SendableChooserCard extends StatefulWidget {
  const SendableChooserCard({super.key, this.chooserName = ""});

  final String chooserName;

  @override
  State<StatefulWidget> createState() => _SendableChooserCard();
}

class _SendableChooserCard extends State<SendableChooserCard> {
  List<String> choices = [];
  String? activeChoice = "";

  NT4Subscription? optionsSub;
  NT4Subscription? activeSub;
  NT4Topic? activePub;

  @override
  void initState() {
    super.initState();

    final String ntTopic = "/SmartDashboard/${widget.chooserName}";
    final String ntOptionsTopic = "$ntTopic/options";
    final String ntActiveTopic = "$ntTopic/selected";

    optionsSub = NTUtils().subscribe(ntOptionsTopic);
    optionsSub!.listen((data) {
      setState(() {
        data as List<Object?>;
        choices.clear();
        for (var d in data) {
          choices.add(d as String);
        }
      });
    });

    activeSub = NTUtils().subscribe(ntActiveTopic);
    activeSub!.listen((data) {
      setState(() {
        data as String;
        activeChoice = data;
      });
    });

    activePub = NTUtils().getPublishTopic(ntActiveTopic, NT4TypeStr.typeStr);
  }

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      width: 2,
      height: 2,
      cardTitle: "Chooser",
      children: [
        RadioGroup<String>(
          groupValue: activeChoice,
          onChanged:
              (value) => setState(() {
                activeChoice = value;
                NTUtils().publishSample(activePub!, value);
              }),
          child: Column(
            children:
                choices.map((choice) {
                  return ListTile(
                    title: Text(choice),
                    leading: Radio<String>(value: choice),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}
