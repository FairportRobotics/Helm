import 'package:flutter/material.dart';
import 'package:helm/ntutils.dart';
import 'package:helm/pages/settings.dart';
import 'package:helm/widgets/base_card.dart';
import 'package:helm/widgets/posty/posty_results_card.dart';
import 'package:helm/widgets/posty/posty_summary_card.dart';
import 'package:helm/widgets/smart_dashboard/sendable_chooser_card.dart';
import 'package:responsive_grid/responsive_grid.dart';
import '../widgets/text_card.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String connectionState = NTUtils().connectionStatus();

  _DashboardState() {
    NTUtils().addConnectCallback(updateConnectionState);
    NTUtils().addDisconnectCallback(updateConnectionState);
  }

  void updateConnectionState() {
    setState(() {
      connectionState = NTUtils().connectionStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Helm - $connectionState"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.checklist)),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(child: Text("Helm")),
              ListTile(
                title: const Text("Settings"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Settings()),
                  );
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ResponsiveGridRow(
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
                              child: TextCard(
                                cardTitle: "Match State",
                                ntTopic: "/FMSInfo/StationNumber",
                              ),
                            ),
                            ResponsiveGridCol(
                              md: 6,
                              child: TextCard(cardTitle: "Match Time"),
                            ),
                            ResponsiveGridCol(md: 6, child: PostyResultsCard()),
                          ],
                        ),
                      ),
                      ResponsiveGridCol(
                        md: 6,
                        child: ResponsiveGridRow(
                          children: [
                            ResponsiveGridCol(
                              child: TextCard(cardTitle: "Blah"),
                            ),
                            ResponsiveGridCol(child: PostySummaryCard()),
                            ResponsiveGridCol(
                              child: SendableChooserCard(
                                chooserName: "SendableChooser[0]",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text("CheckList"),
          ],
        ),
      ),
    );
  }
}
