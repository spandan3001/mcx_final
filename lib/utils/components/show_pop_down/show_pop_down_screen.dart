import 'package:flutter/material.dart';
import 'package:mcx_live/models/order_model.dart';
import 'package:mcx_live/services/api/stream_controller.dart';
import 'package:mcx_live/services/mcx_service.dart';
import 'package:provider/provider.dart';
import '../../../models/data_model.dart';
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
  late String commoditySelected;
  late String buyPrice;
  late String sellPrice;
  int indexOfList = 0;
  late UserModel userModel;

  String _selectedValue = "1";

  DataModel? oldData;

  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: "1");
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
                    .where("isActive", isEqualTo: true)
                    .snapshots(),
                builder: (context, orderSnapshot) {
                  if (orderSnapshot.hasData) {
                    List<OrderModel>? orders = orderSnapshot.data?.docs
                        .map((e) => OrderModel.fromSnapshot(e))
                        .toList();
                    return Container(
                      height: MediaQuery.sizeOf(context).height * 0.45,
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
                                "quantity : ${double.parse(_selectedValue) * 100}%",
                                style: SafeGoogleFont(
                                  'Sofia Pro',
                                  fontSize: fFem * 18,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff1d3a6f),
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      double num = double.parse(_selectedValue);
                                      if (num > 0.0) {
                                        final result = checkConditions(
                                            wallet: userModel.wallet,
                                            orders: orders);

                                        setState(
                                          () {
                                            _selectedValue = (num - 0.1)
                                                .toString()
                                                .substring(0, 3);
                                            _controller = TextEditingController(
                                                text: _selectedValue);
                                          },
                                        );
                                      }
                                    },
                                    icon: const Icon(Icons.remove),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: 50,
                                    child: TextField(
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedValue = value;
                                        });
                                      },
                                      style: SafeGoogleFont(
                                        'Sofia Pro',
                                        fontSize: fFem * 18,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff1d3a6f),
                                      ),
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      controller: _controller,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          double num = 0.1 +
                                              double.parse(_selectedValue);
                                          _selectedValue =
                                              num.toString().substring(0, 3);
                                          _controller = TextEditingController(
                                              text: _selectedValue);
                                        });
                                      },
                                      icon: const Icon(Icons.add)),
                                ],
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
                          const SizedBox(height: 20),

                          StreamBuilder(
                            stream: McxStreamController.stream,
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
                                    const SizedBox(height: 20),
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
                                            const SizedBox(height: 25),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green,
                                                fixedSize:
                                                    Size(fem * 100, fem * 40),
                                              ),
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
                                            const SizedBox(height: 25),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                                fixedSize:
                                                    Size(fem * 100, fem * 40),
                                              ),
                                              onPressed: () {
                                                onPressed(
                                                    BuyORSell.sell, orders);
                                              },
                                              child: Text(
                                                "SELL",
                                                style: SafeGoogleFont(
                                                  'Sofia Pro',
                                                  fontSize: fFem * 18,
                                                  fontWeight: FontWeight.bold,
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
    bool result = await McxService.placeOrder(context,
        userId: userModel.id,
        userEmail: userModel.email,
        token: widget.token,
        placedPoint: buyOrSell == BuyORSell.buy ? buyPrice : sellPrice,
        option: _selectedValue,
        type: buyOrSell.name,
        wallet: userModel.wallet,
        orders: orders);
    Navigator.pop(context);
    if (result) {
      showAlertDialog(context, title: "Done", text: "Successfully placed");
    } else {
      showAlertDialog(context,
          title: "Limit",
          text:
              "Sorry but you cant place the order.\n(Try decreasing the quantity)");
    }
  }

  static bool checkConditions(
      {required String wallet, required List<OrderModel>? orders}) {
    double walletAmt = double.parse(wallet);

    double loot = 0.0;
    if (orders != null) {
      for (OrderModel order in orders) {
        double percentage = double.parse(order.option);
        loot += percentage;
      }
    }

    if (walletAmt < 0) {
      return false;
    }

    if (walletAmt < 1000) {
      if (loot < 0.7) {
        return true;
      } else {
        return false;
      }
    } else if (walletAmt < 20000) {
      if (loot < 1.25) {
        return true;
      } else {
        return false;
      }
    } else if (walletAmt < 40000) {
      if (loot < 1.5) {
        return true;
      } else {
        return false;
      }
    } else if (walletAmt < 70000) {
      if (loot < 2) {
        return true;
      } else {
        return false;
      }
    } else if (walletAmt < 100000) {
      if (loot < 2.5) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }
}
