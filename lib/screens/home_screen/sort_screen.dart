import 'package:flutter/material.dart';
import 'package:mcx_live/ui_screen.dart';
import 'package:mcx_live/utils/components/app_bar.dart';

import '../../models/data_model.dart';

class DataModelCheckbox extends StatefulWidget {
  final List<DataModel> allData;
  final List<DataModel> selectedData;
  final List<Map<String, bool>> checkboxValues; // Changed data structure

  const DataModelCheckbox({
    super.key,
    required this.allData,
    required this.selectedData,
    required this.checkboxValues,
  });

  @override
  State<DataModelCheckbox> createState() => _DataModelCheckboxState();
}

class _DataModelCheckboxState extends State<DataModelCheckbox> {
  @override
  void initState() {
    super.initState();
  }

  void _onCheckboxChanged(String token, bool isChecked) {}

  @override
  Widget build(BuildContext context) {
    return BackGround(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar(
            title: "CHECK LIST",
            onTap: () {
              Navigator.pop(context, widget.checkboxValues);
            }),
        body: ListView.builder(
          itemCount: widget.allData.length,
          itemBuilder: (context, index) {
            final token = widget.allData[index].token;
            int checkIndex = 0;
            for (Map<String, bool> check in widget.checkboxValues) {
              if (check[token] != null) {
                checkIndex = widget.checkboxValues
                    .indexWhere((entry) => entry.keys.toList()[0] == token);
              }
            }
            return ListTile(
              title: Row(
                children: [
                  Text(DataModel.getStringFromToken(token)),
                  Text(DataModel.getExpiryFromToken(token)),
                ],
              ),
              leading: Checkbox(
                value: widget.checkboxValues[checkIndex][token],
                onChanged: (isChecked) {
                  setState(() {
                    widget.checkboxValues[checkIndex][token] = isChecked!;
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
