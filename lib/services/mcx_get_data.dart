import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:mcx_live/screens/mcx_screen/widgets/commodity_card.dart';
import '../models/data_model.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  bool run = true;

  @override
  void initState() {
    super.initState();
    getRequest();
  }

  final url = Uri.parse("https://www.mcxdata.in/");
  StreamController streamController = StreamController();

  List<DataModel> getData(dom.Document html) {
    List<DataModel> dataModelList = [];
    List<dom.Element> content = html.querySelectorAll('tr');
    for (dom.Element element in content) {
      List temp = [];
      if (element.id.isNotEmpty) {
        temp = element
            .querySelectorAll('td')
            .map((e) => e.innerHtml.trim())
            .toList();
      }
      if (temp.isNotEmpty) {
        dataModelList.add(DataModel.fromSnapshot(temp));
      }
    }
    return dataModelList;
  }

  void getRequest() async {
    Timer.periodic(
      const Duration(seconds: 5),
      (timer) async {
        try {
          final response = await http.get(url);
          dom.Document html = dom.Document.html(response.body);
          streamController.sink.add(getData(html));
        } catch (ex) {
          print(ex);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) =>
                    CommodityCard(dataModel: snapshot.data![index]));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
