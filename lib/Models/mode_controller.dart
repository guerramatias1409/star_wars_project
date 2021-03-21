import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';

class ModeController extends ChangeNotifier{
  bool isOnline = true;

  Future<void> changeMode({bool connectivityBoolean}) async{
    print("entro a change mode");
    if(connectivityBoolean == true) {
      var connectivityResult = await Connectivity().checkConnectivity();
      if(connectivityResult != ConnectivityResult.none){
        isOnline = connectivityBoolean;
      }else{
        print("No connection, cant turn online mode on");
      }
    }else{
      print("set false");
      isOnline = connectivityBoolean;
    }
    notifyListeners();
  }
}