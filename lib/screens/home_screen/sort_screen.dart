import 'package:flutter/material.dart';
import 'package:mcx_live/ui_screen.dart';
import 'package:mcx_live/utils/components/app_bar.dart';

import '../../models/data_model.dart';

class DataModelCheckbox extends StatefulWidget {
  final List<DataModel> allData;
  final List<DataModel> selectedData;
  final List<bool> checkboxValues;

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
  List<bool> _checkboxValues = [];

  @override
  void initState() {
    super.initState();
    _initializeCheckboxes();
  }

  void _initializeCheckboxes() {
    _checkboxValues = List.generate(
      widget.allData.length,
      (index) => widget.selectedData
          .any((selected) => selected.token == widget.allData[index].token),
    );
  }

  void _onCheckboxChanged(int index, bool isChecked) {
    setState(() {
      _checkboxValues[index] = isChecked;
      final dataModel = widget.allData[index];
      if (isChecked) {
        // Add the DataModel to the selectedData list
        if (!widget.selectedData.contains(dataModel)) {
          widget.selectedData.add(dataModel);
        }
      } else {
        // Toggle the DataModel's presence in the selectedData list
        widget.selectedData.remove(dataModel);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackGround(
      child: Scaffold(
        appBar: appBar(
            title: "CHECK LIST",
            onTap: () {
              Navigator.pop(context, _checkboxValues);
            }),
        body: ListView.builder(
          itemCount: widget.allData.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Row(
                children: [
                  Text(DataModel.getStringFromToken(
                      widget.allData[index].token)),
                  Text(DataModel.getExpiryFromToken(
                      widget.allData[index].token)),
                ],
              ),
              leading: Checkbox(
                value: _checkboxValues[index],
                onChanged: (isChecked) {
                  _onCheckboxChanged(index, isChecked ?? false);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
