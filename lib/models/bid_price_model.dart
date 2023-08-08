class BidPriceModel {
  final String buySellIndicator;
  final String buySellOrders;
  final String buySellPrice;
  final String buySellQuantity;

  const BidPriceModel(
      {required this.buySellIndicator,
      required this.buySellOrders,
      required this.buySellPrice,
      required this.buySellQuantity});

  factory BidPriceModel.fromSnapshot(Map<String, dynamic> data) {
    return BidPriceModel(
        buySellIndicator: data['buy_sell_indicator'],
        buySellOrders: data['buy_sell_orders'],
        buySellPrice: data['buy_sell_price'],
        buySellQuantity: data['buy_sell_quantity']);
  }
}
