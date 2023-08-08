import 'package:flutter/material.dart';
import 'package:mcx_live/screens/home_screen/drawer.dart';
import 'package:mcx_live/ui_screen.dart';
import '../../models/data_model.dart';
import '../../utils/components/circular_progress.dart';
import '../../utils/google_font.dart';
import 'package:mcx_live/screens/mcx_screen/widgets/commodity_card.dart';
import 'package:mcx_live/screens/mcx_screen/widgets/decorations.dart';
import 'package:mcx_live/services/firestore_services.dart';

class SidePanelScreen extends StatefulWidget {
  const SidePanelScreen({Key? key}) : super(key: key);

  @override
  State<SidePanelScreen> createState() => _SidePanelScreenState();
}

class _SidePanelScreenState extends State<SidePanelScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    //test = data
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
        drawer: drawer(context),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: const TextStyle(
                  color: Colors.black,
                ),
                cursorColor: Colors.black,
                decoration: inputDecorationForTextField(
                    label: "search", hint: "type gold to search GOLD"),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    //getSearchData(value);
                  } else {
                    setState(() {
                      //temp = data;
                    });
                  }
                },
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: CloudService.mcxCollection.snapshots(),
                builder: (context, snapshot) {
                  DataModel dataModel =
                      DataModel.fromSnapshot(snapshot.data!.docs.first);
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) =>
                          CommodityCard(dataModel: dataModel),
                    );
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

// void getSearchData(String value) {
//   setState(() {
//     temp = data
//         .where((element) =>
//             element.commodity.toUpperCase().contains(value.toUpperCase()))
//         .toList();
//   });
// }
}
