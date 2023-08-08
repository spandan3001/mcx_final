import 'package:flutter/material.dart';
import 'package:mcx_live/admin/history_screen.dart';
import 'package:mcx_live/screens/ongoing_history/trade_history_screen.dart';
import 'package:mcx_live/screens/ongoing_history/trade_ongoing.dart';
import 'package:mcx_live/ui_screen.dart';
import 'package:mcx_live/utils/color_constants.dart';
import 'package:mcx_live/utils/components/app_bar.dart';

import '../../utils/components/tab_bar.dart';
import '../../utils/google_font.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BackGround(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(width: 5),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: kGradient1,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTabBar(
                        tabController: tabController,
                        tabs: [
                          Tab(
                            child: Text(
                              "History",
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
                              "Ongoing",
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
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 3,
                child: TabBarView(
                    controller: tabController,
                    children: const [TradeHistory(), TradeOngoing()]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
