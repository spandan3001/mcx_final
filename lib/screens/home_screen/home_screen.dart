import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mcx_live/screens/home_screen/drawer.dart';
import 'package:mcx_live/services/api/api.dart';
import 'package:mcx_live/ui_screen.dart';
import '../../models/data_model_1.dart';
import '../../services/api/stream_controller.dart';
import '../../six_moths_only/trade_symbol.dart';
import '../../utils/components/circular_progress.dart';
import '../../utils/google_font.dart';
import 'package:mcx_live/screens/mcx_screen/widgets/commodity_card.dart';
import 'package:mcx_live/screens/mcx_screen/widgets/decorations.dart';

class SidePanelScreen extends StatefulWidget {
  const SidePanelScreen({Key? key}) : super(key: key);

  @override
  State<SidePanelScreen> createState() => _SidePanelScreenState();
}

class _SidePanelScreenState extends State<SidePanelScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  List<DataModel> temp = [];
  List<DataModel> listDataModel = [];

  String dropDownValue = "10%";

  String searchString = "";
  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      temp = listDataModel;
      if (listDataModel.isNotEmpty) {
        timer.cancel();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {});
        });
      }
    });
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: 200,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextField(
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      cursorColor: Colors.black,
                      decoration: inputDecorationForTextField(
                          hint: "type gold to search GOLD"),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          //getSearchData(value);
                        } else {
                          temp = listDataModel;
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey.shade100,
                    ),
                    child: IconButton(
                      tooltip: "Add trade",
                      onPressed: () {
                        getData();
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: MyStreamController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    listDataModel = snapshot.data!;
                    listDataModel.sort((a, b) => a.token.compareTo(b.token));
                    return ListView.builder(
                      itemCount: tradeSymbol.length,
                      itemBuilder: (BuildContext context, int index) =>
                          CommodityCard(
                        dataModel: listDataModel[index],
                      ),
                    );
                  } else {
                    return const Loading();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void getSearchData(String value) {
  //   // this happens when stream is off
  //
  //   temp = listDataModel.where((element) {
  //     return DataModel.getStringFromToken(element.token)
  //         .toUpperCase()
  //         .contains(value.toUpperCase());
  //   }).toList();
  // }

  // bool getSearchDataReturn(String value) {
  //   return DataModel.getStringFromToken(value)
  //       .toUpperCase()
  //       .contains(searchString.toUpperCase());
  // }
}
