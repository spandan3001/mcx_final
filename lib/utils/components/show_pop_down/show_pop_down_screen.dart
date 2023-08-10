import 'package:flutter/material.dart';
import 'package:mcx_live/models/order_model.dart';
import 'package:mcx_live/services/mcx_service.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import '../../../models/data_model.dart';
import '../../../models/user_model.dart';
import '../../../provider_classes/user_details_provider.dart';
import '../../../services/firestore_services.dart';
import '../circular_progress.dart';
import '../custom_radio_button.dart';

class PopDownSheetForTrade extends StatefulWidget {
  const PopDownSheetForTrade({super.key, required this.commodity});
  final String commodity;

  @override
  State<PopDownSheetForTrade> createState() => _PopDownSheetForTradeState();
}

class _PopDownSheetForTradeState extends State<PopDownSheetForTrade> {
  late String optionDropDownValue;
  late String commoditySelected;
  late String buyPrice;
  late String sellPrice;
  final List<String> dropList = [
    "10%",
    "20%",
    "25%",
    "30%",
    "40%",
    "50%",
    "60%",
    "70%",
    "75%",
    "80%",
    "90%",
    "100%"
  ];
  final List<String> commodities = ["gold", "silver"];
  int indexOfList = 0;
  late UserModel userModel;

  int _selectedValue = 10;
  double _maxValue = 100;
  final double _minValue = 10;
  @override
  void initState() {
    super.initState();
    optionDropDownValue = dropList.last;
    commoditySelected = commodities.last;
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.sizeOf(context).width / baseWidth;
    double fFem = fem * 0.97;
    userModel = Provider.of<UserProvider>(context, listen: false).getUser();

    return StreamBuilder(
        stream: CloudService.userCollection
            .where("email", isEqualTo: userModel.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            userModel = UserModel.fromSnapshot(snapshot.data!.docs.single);
            return StreamBuilder(
                stream: CloudService.orderCollection
                    .where("userId", isEqualTo: userModel.id)
                    .snapshots(),
                builder: (context, orderSnapshot) {
                  if (orderSnapshot.hasData) {
                    List<OrderModel>? orders = orderSnapshot.data?.docs
                        .map((e) => OrderModel.fromSnapshot(e))
                        .toList();
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //a circular bordered box for the pop down menu
                          Center(
                            child: Container(
                              height: 6,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "quantity : $_selectedValue%",
                                style: TextStyle(
                                    color: Colors.black, fontSize: fFem * 18),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(10)),
                                child: NumberPicker(
                                  haptics: true,
                                  textStyle: TextStyle(fontSize: fFem * 10),
                                  itemHeight: fem * 50,
                                  itemWidth: fem * 50,
                                  axis: Axis.horizontal,
                                  value: _selectedValue,
                                  minValue: _minValue.toInt(),
                                  maxValue: _maxValue.toInt(),
                                  step:
                                      10, // Set the step to 10 to allow selecting only multiples of ten
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedValue = value;
                                      final result =
                                          checkConditionReturnPattern(
                                              wallet: userModel.wallet,
                                              orders: orders);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Wallet:-${userModel.wallet}",
                            style: TextStyle(fontSize: fFem * 20),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              "GOLD PRICE",
                              style: TextStyle(fontSize: fFem * 20),
                            ),
                          ),
                          const SizedBox(height: 5),
                          StreamBuilder(
                            stream: CloudService.mcxCollection
                                .where("token", isEqualTo: "254924")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                DataModel dataModel = DataModel.fromSnapshot(
                                    snapshot.data!.docs.first);
                                buyPrice = dataModel.buy;
                                sellPrice = dataModel.sell;

                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade100,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Text(dataModel.buy)),
                                            const SizedBox(height: 5),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.green),
                                              onPressed: () {
                                                onPressed(
                                                    TradeOptions.buy, orders);
                                              },
                                              child: const Text("BUY"),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade100,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Text(dataModel.sell)),
                                            const SizedBox(height: 5),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red),
                                              onPressed: () {
                                                onPressed(
                                                    TradeOptions.sell, orders);
                                              },
                                              child: const Text("SELL"),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              } else {
                                return const Loading();
                              }
                            },
                          )
                        ],
                      ),
                    );
                  } else {
                    return const Loading();
                  }
                });
          } else {
            return const Loading();
          }
        });
  }

  Future<void> onPressed(
      TradeOptions buyOrSell, List<OrderModel>? orders) async {
    bool result = await McxService.placeOrder(
        userId: userModel.id,
        userEmail: userModel.email,
        commodity: widget.commodity,
        price: buyOrSell == TradeOptions.buy ? buyPrice : sellPrice,
        option: optionDropDownValue,
        type: buyOrSell.name,
        wallet: userModel.wallet,
        orders: orders);
    print(result);
  }

  (bool, double) checkConditionReturnPattern(
      {required String wallet, required List<OrderModel>? orders}) {
    double walletAmt = double.parse(wallet);

    double totalPercentage = 0.0;
    if (orders != null) {
      for (OrderModel order in orders) {
        double percentage =
            double.parse(order.option.substring(0, order.option.length - 1));
        totalPercentage += percentage;
      }
    }
    double loot = totalPercentage / 100;

    if (walletAmt < 10000) {
      if (loot < McxService.lootLimitList[10000]!) {
        _maxValue = McxService.lootLimitList[10000]! * 100;
        return (true, totalPercentage);
      } else {
        return (false, totalPercentage);
      }
    } else if (walletAmt < 20000) {
      if (loot < McxService.lootLimitList[20000]!) {
        _maxValue = McxService.lootLimitList[20000]! * 100;
        return (true, totalPercentage);
      } else {
        return (false, totalPercentage);
      }
    } else if (walletAmt < 40000) {
      if (loot < McxService.lootLimitList[40000]!) {
        _maxValue = McxService.lootLimitList[40000]! * 100;
        return (true, totalPercentage);
      } else {
        return (false, totalPercentage);
      }
    } else if (walletAmt < 70000) {
      if (loot < McxService.lootLimitList[70000]!) {
        _maxValue = McxService.lootLimitList[70000]! * 100;
        return (true, totalPercentage);
      } else {
        return (false, totalPercentage);
      }
    } else if (walletAmt < 100000) {
      if (loot < McxService.lootLimitList[100000]!) {
        _maxValue = McxService.lootLimitList[100000]! * 100;
        return (true, totalPercentage);
      } else {
        return (false, totalPercentage);
      }
    } else {
      _maxValue = 1000;
      return (true, totalPercentage);
    }
  }
}
