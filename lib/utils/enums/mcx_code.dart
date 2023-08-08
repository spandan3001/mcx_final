import 'package:webview_flutter/webview_flutter.dart';

enum McxCom {
  gold,
  goldM,
  silver,
  silverM,
  copper,
  aluminium,
  crudeOil,
  zinc,
  naturalGas,
  silverMic,
  goldPetal,
  lead
}

class WebController {
  static Map<String, WebViewController> controllers = {
    "gold": WebViewController(),
    "goldM": WebViewController(),
    "silver": WebViewController(),
    "silverM": WebViewController(),
    "copper": WebViewController(),
    "aluminium": WebViewController(),
    "crudeOil": WebViewController(),
    "zinc": WebViewController(),
    "natural": WebViewController(),
    "silverMic": WebViewController(),
    "goldPetal": WebViewController(),
    "lead": WebViewController(),
  };
}
