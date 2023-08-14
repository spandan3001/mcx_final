import 'package:flutter/material.dart';
import 'package:mcx_live/provider_classes/platinum_provider.dart';
import 'package:mcx_live/screens/home_screen/drawer.dart';
import 'package:mcx_live/screens/home_screen/sort_screen.dart';
import 'package:mcx_live/services/api/api.dart';
import 'package:mcx_live/ui_screen.dart';
import '../../models/data_model.dart';
import '../../services/api/stream_controller.dart';
import '../../six_moths_only/trade_symbol.dart';
import '../../utils/components/circular_progress.dart';
import '../../utils/google_font.dart';
import 'package:mcx_live/screens/mcx_screen/widgets/commodity_card.dart';
import 'package:mcx_live/screens/mcx_screen/widgets/decorations.dart';

class SidePanelScreen extends StatefulWidget {
  const SidePanelScreen({Key? key, required this.isAdmin}) : super(key: key);
  final bool isAdmin;

  @override
  State<SidePanelScreen> createState() => _SidePanelScreenState();
}

class _SidePanelScreenState extends State<SidePanelScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  List<DataModel> listDataModel = [];
  List<DataModel> sListDataModel = [];
  Map<String, BuySellModel> oldMcxData = {};
  Map<String, ColorModel> colorSet = {};
  String searchString = "";

  List<bool> checkboxValues = [];
  @override
  void initState() {
    super.initState();
    getData();
    getOrders();
    updateHistoryOrders();
    _initializeCheckboxes();
    PlatinumProvider.getUserFromDB();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    timerForMcx.cancel();
    timerForOrders.cancel();
    // McxStreamController.dispose();
    // OrderStreamController.dispose();
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
        drawer: drawer(context, widget.isAdmin),
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
                        searchString = value.toUpperCase();
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DataModelCheckbox(
                              allData: listDataModel,
                              selectedData: sListDataModel,
                              checkboxValues: checkboxValues,
                            ),
                          ),
                        ).then(
                          (value) {
                            checkboxValues = value;
                          },
                        );
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
                stream: McxStreamController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    listDataModel = [];
                    sListDataModel = [];
                    listDataModel = snapshot.data!;
                    searchModel();
                    giveColors();
                    return ListView.builder(
                        itemCount: sListDataModel.length,
                        itemBuilder: (BuildContext context, int index) {
                          ColorModel? colors =
                              colorSet[sListDataModel[index].token];
                          return CommodityCard(
                            dataModel: sListDataModel[index],
                            colorSet: colors ??
                                ColorModel(
                                    buyColor: Colors.transparent,
                                    sellColor: Colors.transparent),
                          );
                        });
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

  void searchModel() {
    listDataModel.sort(
      (a, b) => a.token.compareTo(b.token),
    );
    sortTradeSymbol();
    final values = singleCom.values;

    int index = 0;
    List<DataModel> temp = [];
    for (index = 0; index < checkboxValues.length; index++) {
      if (checkboxValues[index]) {
        temp.add(listDataModel[index]);
      }
    }
    sListDataModel = temp;

    sListDataModel = temp.where((element) {
      if (DataModel.getStringFromToken(element.token).contains(searchString)) {
        for (Map<String, dynamic> value in values) {
          if (element.token.contains(value["token"])) {
            return true;
          }
        }
        return false;
      } else {
        return false;
      }
    }).toList();
  }

  void giveColors() {
    if (oldMcxData.isNotEmpty) {
      for (DataModel dataModel in listDataModel) {
        BuySellModel buySellModel = BuySellModel(
            sellPoint: double.parse(dataModel.bestFiveData[0].buySellPrice),
            buyPoint: double.parse(dataModel.bestFiveData[5].buySellPrice));
        final ColorModel colorModel = ColorModel(
            buyColor: comparePoint(
                buySellModel.buyPoint, oldMcxData[dataModel.token]!.buyPoint),
            sellColor: comparePoint(buySellModel.sellPoint,
                oldMcxData[dataModel.token]!.sellPoint));
        colorSet.addAll({dataModel.token: colorModel});
      }
    }
    for (DataModel dataModel in listDataModel) {
      BuySellModel buySellModel = BuySellModel(
          sellPoint: double.parse(dataModel.bestFiveData[0].buySellPrice),
          buyPoint: double.parse(dataModel.bestFiveData[5].buySellPrice));
      oldMcxData.addAll(
        {dataModel.token: buySellModel},
      );
    }
  }

  Color comparePoint(double curPoint, double oldPoint) {
    if (curPoint < oldPoint) {
      return Colors.red;
    } else if (curPoint > oldPoint) {
      return Colors.green;
    } else {
      return Colors.transparent;
    }
  }

  void _initializeCheckboxes() {
    checkboxValues = List.generate(
      listDataModel.length,
      (index) => sListDataModel
          .any((selected) => selected.token == listDataModel[index].token),
    );
  }
}

class BuySellModel {
  BuySellModel({required this.sellPoint, required this.buyPoint});

  final double buyPoint;
  final double sellPoint;
}
