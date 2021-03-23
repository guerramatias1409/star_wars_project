import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';

class ModeController extends ChangeNotifier{
  bool isOnline = true;
  bool cantSwitch = false;

  Future<int> changeMode({bool connectivityBoolean}) async{
    if(connectivityBoolean == true) {
      var connectivityResult = await Connectivity().checkConnectivity();
      if(connectivityResult != ConnectivityResult.none){
        isOnline = connectivityBoolean;
        notifyListeners();
        return 1;
      }else{
        return 0;
      }
    }else{
      isOnline = connectivityBoolean;
      notifyListeners();
      return 1;
    }
  }

  void changeCantSwitch(bool value){
    cantSwitch = value;
    notifyListeners();
  }
}