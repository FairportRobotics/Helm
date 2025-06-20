import 'package:flutter/material.dart';
import 'package:helm/widgets/base_card.dart';
import 'package:responsive_grid/responsive_grid.dart';
import '../widgets/text_card.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Helm"),
      ),
      body: ResponsiveGridRow(
        children: [
          ResponsiveGridCol(
            md: 12,
            child: ResponsiveGridRow(
              children: [
                ResponsiveGridCol(
                  md: 6,
                  child: BaseCard(cardTitle: "Reef Picker", height: 4),
                ),
                ResponsiveGridCol(
                  md: 6,
                  child: ResponsiveGridRow(
                    children: [
                      ResponsiveGridCol(
                        md: 6,
                        child: TextCard(cardTitle: "Match State"),
                      ),
                      ResponsiveGridCol(
                        md: 6,
                        child: TextCard(cardTitle: "Match Time"),
                      ),
                      ResponsiveGridCol(
                        md: 6,
                        child: TextCard(cardTitle: "Blah Blah"),
                      ),
                    ],
                  ),
                ),
                ResponsiveGridCol(
                  md: 6,
                  child: ResponsiveGridRow(
                    children: [
                      ResponsiveGridCol(child: TextCard(cardTitle: "Blah")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
