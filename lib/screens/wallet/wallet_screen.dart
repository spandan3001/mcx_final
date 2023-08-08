import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mcx_live/screens/wallet/services/wallet_service.dart';
import 'package:mcx_live/screens/wallet/utils/enums.dart';
import 'package:mcx_live/screens/wallet/utils/fixed_amount_button.dart';
import 'package:mcx_live/screens/wallet/utils/show_pop_down.dart';
import 'package:mcx_live/services/firestore_services.dart';
import 'package:mcx_live/ui_screen.dart';
import 'package:mcx_live/utils/components/app_bar.dart';
import 'package:mcx_live/utils/components/show_dialog.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../provider_classes/user_details_provider.dart';
import '../../utils/color_constants.dart';
import '../../utils/text_style.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key, required this.type});
  final TypeOfSubmit type;

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  TextEditingController editingController = TextEditingController(text: "6000");
  Amount selected = Amount.a6000;
  @override
  Widget build(BuildContext context) {
    UserModel userModelProvider =
        Provider.of<UserProvider>(context, listen: false).getUser();
    return BackGround(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar(
          title: "WALLET",
          onTap: () {
            Navigator.pop(context);
          },
        ),
        body: StreamBuilder(
            stream: CloudService.userCollection
                .where("email", isEqualTo: userModelProvider.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserModel userModel =
                    UserModel.fromSnapshot(snapshot.data!.docs.first);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.1),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            border: Border.all(color: kBorderColor),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total amount:',
                                style: SafeGoogleFont(
                                  'Sofia Pro',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(width: 5),
                              RichText(
                                textAlign: TextAlign.right,
                                text: TextSpan(
                                  style: SafeGoogleFont('Sofia Pro',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: kGradient1),
                                  children: [
                                    TextSpan(
                                      text: '₹',
                                      style: SafeGoogleFont('ITF Rupee'),
                                    ),
                                    TextSpan(
                                      text: userModel.wallet,
                                      style: SafeGoogleFont('Sofia Pro'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: kBorderColor),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Enter amount:',
                                style: SafeGoogleFont(
                                  'Sofia Pro',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                              // Text(
                              //   '₹',
                              //   style: SafeGoogleFont(
                              //     'ITF Rupee',
                              //     fontSize: 20,
                              //     fontWeight: FontWeight.bold,
                              //     color: kGradient1,
                              //   ),
                              // ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.5,
                                height: 50,
                                child: TextField(
                                  textDirection: TextDirection.rtl,
                                  controller: editingController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  style: SafeGoogleFont('Roboto',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: kGradient1),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                        ),

                        ///done
                        const SizedBox(height: 50),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AmountButton(
                              selected: selected,
                              onTap: () {
                                setState(() {
                                  selected = Amount.a1500;
                                  editingController = TextEditingController(
                                      text: selected.name.substring(1));
                                });
                              },
                              value: Amount.a1500,
                            ),
                            const SizedBox(width: 20),
                            AmountButton(
                              selected: selected,
                              onTap: () {
                                setState(() {
                                  selected = Amount.a3000;
                                  editingController = TextEditingController(
                                      text: selected.name.substring(1));
                                });
                              },
                              value: Amount.a3000,
                            ),
                            const SizedBox(width: 20),
                            AmountButton(
                              selected: selected,
                              onTap: () {
                                setState(() {
                                  selected = Amount.a6000;
                                  editingController = TextEditingController(
                                      text: selected.name.substring(1));
                                });
                              },
                              value: Amount.a6000,
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        InkWell(
                          onTap: () async {
                            final bool result;
                            if (widget.type == TypeOfSubmit.add) {
                              result = await addAmount(
                                  context, editingController.text, userModel);
                            } else {
                              result = withdrawAmount(
                                  context, editingController.text, userModel);
                            }
                            if (result == true) {
                              showAlertDialog(context,
                                  text:
                                      "The request was sent to admin.please wait for admin verification ",
                                  title: "Done 🎉");
                            } else {
                              showAlertDialog(context,
                                  text: "Sorry something went wrong",
                                  title: "Sorry😕");
                            }
                          },
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: const LinearGradient(
                                begin: Alignment(0, -1),
                                end: Alignment(0, 1),
                                colors: [kGradient1, kGradient2, kGradient3],
                                stops: <double>[0, 1, 2],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                widget.type.name.toUpperCase(),
                                style: SafeGoogleFont(
                                  'Sofia Pro',
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const ShowPopDownButton(),
                      ],
                    ),
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
