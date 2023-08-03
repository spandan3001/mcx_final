import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mcx_live/screens/wallet/services/wallet_service.dart';
import 'package:mcx_live/screens/wallet/utils/enums.dart';
import 'package:mcx_live/screens/wallet/utils/fixed_amount_button.dart';
import 'package:mcx_live/utils/components/show_dialog.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../provider_classes/user_detials_provider.dart';
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
    UserModel userModel =
        Provider.of<UserProvider>(context, listen: false).getUser();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WALLET',
          textAlign: TextAlign.center,
          style: SafeGoogleFont(
            'Poppins',
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      bottomNavigationBar:
          Image.asset("images/line_chart.png", fit: BoxFit.fill),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                          fontSize: 21,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(width: 5),
                      RichText(
                        textAlign: TextAlign.right,
                        text: TextSpan(
                          style: SafeGoogleFont('Sofia Pro',
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
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
                const SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 10, left: 10, right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: kBorderColor),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Enter amount:',
                            style: SafeGoogleFont(
                              'Sofia Pro',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            'Top up fee ₹300.0',
                            style: SafeGoogleFont(
                              'Sofia Pro',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                'IND',
                                style: SafeGoogleFont(
                                  'Roboto',
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                  color: kBorderColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 100,
                            height: 50,
                            child: TextField(
                              controller: editingController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              style: SafeGoogleFont('Roboto',
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                  color: kGradient1),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                  onTap: () {
                    final bool result = widget.type == TypeOfSubmit.add
                        ? addAmount(editingController.text, userModel)
                        : withdrawAmount(editingController.text, userModel);
                    if (result) {
                      showAlertDialog(context,
                          text:
                              "The request was sent to admin.please wait for admin verification ",
                          title: "Done 🎉");
                    } else {
                      showAlertDialog(context,
                          text: "Something went wrong", title: "Retry😕");
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
