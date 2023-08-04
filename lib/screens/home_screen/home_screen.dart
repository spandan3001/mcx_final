import 'package:flutter/material.dart';
import 'package:mcx_live/screens/home_screen/drawer.dart';
import 'package:mcx_live/ui_screen.dart';
import '../../utils/components/tab_bar.dart';
import '../../utils/google_font.dart';
import '../mcx_screen/mcx_list_tab.dart';

class SidePanelScreen extends StatefulWidget {
  const SidePanelScreen({Key? key}) : super(key: key);
  @override
  State<SidePanelScreen> createState() => _SidePanelScreenState();
}

class _SidePanelScreenState extends State<SidePanelScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BackGround(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Text(
            'MCX',
            textAlign: TextAlign.center,
            style: SafeGoogleFont(
              'Poppins',
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          centerTitle: true,
        ),
        drawer: drawer(context),
        body: Column(
          children: [
            CustomTabBar(
              tabController: tabController,
              tabs: [
                Tab(
                  child: Text(
                    "LIST",
                    style: SafeGoogleFont(
                      'Sofia Pro',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff1d3a6f),
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "CHART",
                    style: SafeGoogleFont(
                      'Sofia Pro',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff1d3a6f),
                    ),
                  ),
                )
              ],
              onTap: (value) {},
            ),
            Expanded(
              child: TabBarView(controller: tabController, children: const [
                MCXListScreen(),
                Text("hello"),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
