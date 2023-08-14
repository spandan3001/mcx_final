import '../models/data_model.dart';

final tradeSymbol = {
  "000000": {"symbol": "PLATINUM23AUGFUT", "expiry": "31AUG2023"},
  "247117": {"symbol": "SILVERM23AUGFUT", "expiry": "31AUG2023"},
  "248401": {"symbol": "SILVERM23NOVFUT", "expiry": "30NOV2023"},
  "254351": {"symbol": "SILVERM24FEBFUT", "expiry": "29FEB2024"},
  "256949": {"symbol": "SILVERM24APRFUT", "expiry": "30APR2024"},
  "258634": {"symbol": "SILVERM24JUNFUT", "expiry": "28JUN2024"},
  "247116": {"symbol": "SILVER23SEPFUT", "expiry": "05SEP2023"},
  "250882": {"symbol": "SILVER23DECFUT", "expiry": "05DEC2023"},
  "254350": {"symbol": "SILVER24MARFUT", "expiry": "05MAR2024"},
  "256948": {"symbol": "SILVER24MAYFUT", "expiry": "03MAY2024"},
  "258633": {"symbol": "SILVER24JULFUT", "expiry": "05JUL2024"},
  "257449": {"symbol": "NATURALGAS23AUGFUT", "expiry": "28AUG2023"},
  "258270": {"symbol": "NATURALGAS23SEPFUT", "expiry": "26SEP2023"},
  "259036": {"symbol": "NATURALGAS23OCTFUT", "expiry": "26OCT2023"},
  "253460": {"symbol": "CRUDEOIL23AUGFUT", "expiry": "21AUG2023"},
  "254924": {"symbol": "CRUDEOIL23SEPFUT", "expiry": "19SEP2023"},
  "256293": {"symbol": "CRUDEOIL23OCTFUT", "expiry": "19OCT2023"},
  "257264": {"symbol": "CRUDEOIL23NOVFUT", "expiry": "17NOV2023"},
  "258003": {"symbol": "CRUDEOIL23DECFUT", "expiry": "18DEC2023"},
  "255304": {"symbol": "COPPER23AUGFUT", "expiry": "31AUG2023"},
  "256550": {"symbol": "COPPER23SEPFUT", "expiry": "29SEP2023"},
  "257618": {"symbol": "COPPER23OCTFUT", "expiry": "31OCT2023"},
  "258364": {"symbol": "COPPER23NOVFUT", "expiry": "30NOV2023"},
  "259238": {"symbol": "COPPER23DECFUT", "expiry": "29DEC2023"},
  "250060": {"symbol": "SILVERMIC23AUGFUT", "expiry": "31AUG2023"},
  "253811": {"symbol": "SILVERMIC23NOVFUT", "expiry": "30NOV2023"},
  "257631": {"symbol": "SILVERMIC24FEBFUT", "expiry": "29FEB2024"},
  "255317": {"symbol": "ZINC23AUGFUT", "expiry": "31AUG2023"},
  "256553": {"symbol": "ZINC23SEPFUT", "expiry": "29SEP2023"},
  "257626": {"symbol": "ZINC23OCTFUT", "expiry": "31OCT2023"},
  "258378": {"symbol": "ZINC23NOVFUT", "expiry": "30NOV2023"},
  "259242": {"symbol": "ZINC23DECFUT", "expiry": "29DEC2023"},
  "255298": {"symbol": "ALUMINIUM23AUGFUT", "expiry": "31AUG2023"},
  "256549": {"symbol": "ALUMINIUM23SEPFUT", "expiry": "29SEP2023"},
  "257609": {"symbol": "ALUMINIUM23OCTFUT", "expiry": "31OCT2023"},
  "258363": {"symbol": "ALUMINIUM23NOVFUT", "expiry": "30NOV2023"},
  "259237": {"symbol": "ALUMINIUM23DECFUT", "expiry": "29DEC2023"},
  "248400": {"symbol": "GOLD23OCTFUT", "expiry": "05OCT2023"},
  "250883": {"symbol": "GOLD23DECFUT", "expiry": "05DEC2023"},
  "253322": {"symbol": "GOLD24FEBFUT", "expiry": "05FEB2024"},
  "256171": {"symbol": "GOLD24APRFUT", "expiry": "05APR2024"},
  "257896": {"symbol": "GOLD24JUNFUT", "expiry": "05JUN2024"},
  "257740": {"symbol": "GOLDM23SEPFUT", "expiry": "05SEP2023"},
  "258460": {"symbol": "GOLDM23OCTFUT", "expiry": "05OCT2023"},
  "259273": {"symbol": "GOLDM23NOVFUT", "expiry": "03NOV2023"}
};

DateTime convertStringToDate(String str) {
  String year = str.substring(5);
  String month = str.substring(2, 5);
  String day = str.substring(0, 2);

  return DateTime(int.parse(year), months[month]!, int.parse(day));
}

Map<String, dynamic> selectedCom = {};
Map<String, dynamic> singleCom = {};

void sortTradeSymbol() {
  tradeSymbol.forEach((key, value) {
    DateTime expiry = convertStringToDate(value['expiry']!);
    DateTime? time = singleCom[DataModel.getStringFromToken(key)]?['expiry'];
    if (time != null) {
      if (time.isAfter(expiry)) {
        singleCom[DataModel.getStringFromToken(key)] = {
          'expiry': expiry,
          'token': key
        };
      }
    } else {
      singleCom[DataModel.getStringFromToken(key)] = {
        'expiry': expiry,
        'token': key
      };
    }
  });
}

final months = {
  "JAN": 1,
  "FEB": 2,
  "MAR": 3,
  "APR": 4,
  "MAY": 5,
  "JUN": 6,
  "JUL": 7,
  "AUG": 8,
  "SEP": 9,
  "OCT": 10,
  "NOV": 11,
  "DEC": 12,
};

final price = {
  "GOLD": 100.0,
  "SILVER": 30.0,
  "CRUDEOIL": 100.0,
  "COPPER": 2500.0,
  "NATURALGAS": 1250.0,
  "ZINC": 5000.0,
  "ALUMINIUM": 5000.0,
  "LEAD": 5000.0,
  "SILVERM": 5.0,
  "PLATINUM": 250.0,
  "SILVERMIC": 1.0,
  "GOLDM": 10.0
};
