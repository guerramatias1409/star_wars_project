import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';

class ConnectivityController extends ChangeNotifier {
  bool isOnline = true;
  bool cantSwitch = false;

  Future<void> changeMode({bool connectivityBoolean}) async {
    if (connectivityBoolean == true) {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        isOnline = connectivityBoolean;
        cantSwitch = false;
        notifyListeners();
      } else {
        cantSwitch = true;
        notifyListeners();
      }
    } else {
      isOnline = connectivityBoolean;
      cantSwitch = false;
      notifyListeners();
    }
  }

  void changeCantSwitch(bool value) {
    cantSwitch = value;
    notifyListeners();
  }
}
