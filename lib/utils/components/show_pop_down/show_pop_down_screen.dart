import 'package:flutter/material.dart';
import 'package:mcx_live/models/order_model.dart';
import 'package:mcx_live/services/api/stream_controller.dart';
import 'package:mcx_live/services/mcx_service.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import '../../../models/data_model_1.dart';
import '../../../models/user_model.dart';
import '../../../provider_classes/user_details_provider.dart';
import '../../../services/firestore_services.dart';
import '../../google_font.dart';
import '../circular_progress.dart';
import '../custom_radio_button.dart';
import '../show_dialog.dart';

class PopDownSheetForTrade extends StatefulWidget {
  const PopDownSheetForTrade({super.key, required this.token});
  final String token;

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
  int indexOfList = 0;
  late UserModel userModel;

  int _selectedValue = 10;
  double _maxValue = 100;
  final double _minValue = 10;

  DataModel? oldData;
  @override
  void initState() {
    super.initState();
    optionDropDownValue = dropList.last;
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
                      height: MediaQuery.sizeOf(context).height * 0.4,
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
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "quantity : $_selectedValue%",
                                style: SafeGoogleFont(
                                  'Sofia Pro',
                                  fontSize: fFem * 18,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff1d3a6f),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(10)),
                                child: NumberPicker(
                                  haptics: true,
                                  textStyle: SafeGoogleFont(
                                    'Sofia Pro',
                                    fontSize: fFem * 12,
                                    color: const Color(0xff1d3a6f),
                                  ),
                                  selectedTextStyle: SafeGoogleFont(
                                    'Sofia Pro',
                                    fontSize: fFem * 20,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff1d3a6f),
                                  ),
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
                            "Wallet:-₹${userModel.wallet}",
                            style: SafeGoogleFont(
                              'Sofia Pro',
                              fontSize: fFem * 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff1d3a6f),
                            ),
                          ),
                          const SizedBox(height: 10),

                          StreamBuilder(
                            stream: MyStreamController.stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<DataModel> dataModels = snapshot.data!
                                    .where((element) =>
                                        element.token.contains(widget.token))
                                    .toList();
                                DataModel dataModel;
                                if (dataModels.isNotEmpty) {
                                  dataModel = dataModels[0];
                                } else {
                                  dataModel = (oldData != null)
                                      ? oldData!
                                      : dataModels.first;
                                }
                                oldData = dataModel;
                                buyPrice =
                                    dataModel.bestFiveData[0].buySellPrice;
                                sellPrice =
                                    dataModel.bestFiveData[5].buySellPrice;

                                return Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Text(
                                        "${DataModel.getStringFromToken(dataModel.token)} PRICE",
                                        style: SafeGoogleFont(
                                          'Sofia Pro',
                                          fontSize: fFem * 18,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xff1d3a6f),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Text(
                                                buyPrice,
                                                style: SafeGoogleFont(
                                                  'Sofia Pro',
                                                  fontSize: fFem * 18,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      const Color(0xff1d3a6f),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.green),
                                              onPressed: () {
                                                onPressed(
                                                    BuyORSell.buy, orders);
                                              },
                                              child: Text(
                                                "BUY",
                                                style: SafeGoogleFont(
                                                  'Sofia Pro',
                                                  fontSize: fFem * 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Text(
                                                sellPrice,
                                                style: SafeGoogleFont(
                                                  'Sofia Pro',
                                                  fontSize: fFem * 18,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      const Color(0xff1d3a6f),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red),
                                              onPressed: () {
                                                onPressed(
                                                    BuyORSell.sell, orders);
                                              },
                                              child: Text(
                                                "SELL",
                                                style: SafeGoogleFont(
                                                  'Sofia Pro',
                                                  fontSize: fFem * 18,
                                                ),
                                              ),
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

  Future<void> onPressed(BuyORSell buyOrSell, List<OrderModel>? orders) async {
    bool result = await McxService.placeOrder(
        userId: userModel.id,
        userEmail: userModel.email,
        commodity: widget.token,
        price: buyOrSell == BuyORSell.buy ? buyPrice : sellPrice,
        option: optionDropDownValue,
        type: buyOrSell.name,
        wallet: userModel.wallet,
        orders: orders);
    Navigator.pop(context);
    if (result) {
      showAlertDialog(context, title: "Done", text: "Successfully placed");
    } else {
      showAlertDialog(context,
          title: "Error", text: "There was some error while palcing");
    }
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
