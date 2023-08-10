import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar(
      {Key? key,
      required this.tabController,
      required this.tabs,
      required this.onTap})
      : super(key: key);

  final TabController tabController;
  final List<Tab> tabs;
  final Function(int value) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.08,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: const BoxDecoration(
        color: Color(0xFF02BDEC),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: TabBar(
        onTap: onTap,
        unselectedLabelColor: Colors.white,
        labelColor: Colors.black,
        indicator: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        controller: tabController,
        tabs: tabs,
      ),
    );
  }
}
