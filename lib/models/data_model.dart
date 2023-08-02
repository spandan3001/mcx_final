class DataModel {
  final String commodity;
  final String price;
  final String chg;
  final String chgPercent;
  final String open;
  final String high;
  final String low;
  final String time;

  const DataModel(
      {required this.commodity,
      required this.price,
      required this.chg,
      required this.chgPercent,
      required this.open,
      required this.low,
      required this.time,
      required this.high});

  factory DataModel.fromSnapshot(List<dynamic> data) {
    return DataModel(
      commodity: data[0],
      price: data[1],
      chg: data[2],
      chgPercent: data[3],
      open: data[4],
      high: data[5],
      low: data[6],
      time: data[7],
    );
  }
}
