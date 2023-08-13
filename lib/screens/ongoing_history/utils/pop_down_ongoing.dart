import 'package:flutter/material.dart';
import 'package:mcx_live/services/api/stream_controller.dart';
import 'package:mcx_live/utils/color_constants.dart';
import 'package:provider/provider.dart';
import '../../../models/data_model.dart';
import '../../../models/user_model.dart';
import '../../../provider_classes/user_details_provider.dart';
import '../../../services/firestore_services.dart';
import '../../../six_moths_only/trade_symbol.dart';
import '../../../utils/components/circular_progress.dart';
import '../../../utils/components/custom_radio_button.dart';
import '../../../utils/google_font.dart';

class PopDownSheetForOngoing extends StatefulWidget {
  const PopDownSheetForOngoing(
      {super.key,
      required this.token,
      required this.placedPoint,
      required this.type});
  final String token;
  final String placedPoint;
  final String type;

  @override
  State<PopDownSheetForOngoing> createState() => _PopDownSheetForOngoingState();
}

class _PopDownSheetForOngoingState extends State<PopDownSheetForOngoing> {
  late String optionDropDownValue;
  late String commoditySelected;
  late String buyPrice;
  late String priceOfType;
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
            return Container(
              height: MediaQuery.sizeOf(context).height * 0.3,
              width: MediaQuery.sizeOf(context).width * 0.3,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 20, top: 5),
              child: Column(
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
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
                            buyPrice = dataModel.bestFiveData[5].buySellPrice;
                            sellPrice = dataModel.bestFiveData[0].buySellPrice;
                            if (widget.type == BuyORSell.buy.name) {
                              priceOfType = buyPrice;
                            } else {
                              priceOfType = sellPrice;
                            }
                            return Column(
                              children: [
                                Text(
                                  "Wallet: ₹${getDifferenceInPriceWallet(priceOfType, DataModel.getStringFromToken(widget.token))}",
                                  style: SafeGoogleFont(
                                    'Sofia Pro',
                                    fontSize: fFem * 18,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff1d3a6f),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(20)),
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
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            buyPrice,
                                            style: SafeGoogleFont(
                                              'Sofia Pro',
                                              fontSize: fFem * 18,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xff1d3a6f),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            sellPrice,
                                            style: SafeGoogleFont(
                                              'Sofia Pro',
                                              fontSize: fFem * 18,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xff1d3a6f),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                      ],
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: kGradient1),
                                  onPressed: () {},
                                  child: Text(
                                    "close trade",
                                    style: SafeGoogleFont(
                                      'Sofia Pro',
                                      fontSize: fFem * 18,
                                    ),
                                  ),
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
                ],
              ),
            );
          } else {
            return const Loading();
          }
        });
  }

  Future<void> onPressed() async {}

  String getDifferenceInPriceWallet(String actualPoints, String commodity) {
    double placed = double.parse(widget.placedPoint);
    double actual = double.parse(actualPoints);
    double walletAmt = double.parse(userModel.wallet);

    return (walletAmt + ((actual - placed) * price[commodity]!))
        .roundToDouble()
        .toString();
  }
}
