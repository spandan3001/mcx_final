import 'package:flutter/material.dart';
import 'package:mcx_live/screens/ongoing_history/trade_history_screen.dart';
import 'package:mcx_live/screens/ongoing_history/trade_ongoing_screen.dart';
import 'package:mcx_live/ui_screen.dart';
import 'package:mcx_live/utils/color_constants.dart';
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
    double baseWidth = 360;
    double fem = MediaQuery.sizeOf(context).width / baseWidth;
    double fFem = fem * 0.97;
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
                    width: 48 * fFem,
                    height: 48 * fFem,
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
                              "Ongoing",
                              style: SafeGoogleFont(
                                'Sofia Pro',
                                fontSize: 18 * fFem,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff1d3a6f),
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "History",
                              style: SafeGoogleFont(
                                'Sofia Pro',
                                fontSize: 18 * fFem,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff1d3a6f),
                              ),
                            ),
                          ),
                        ],
                        onTap: (value) {},
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                    controller: tabController,
                    children: const [TradeOngoing(), TradeHistory()]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
