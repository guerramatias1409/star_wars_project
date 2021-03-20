import 'package:flutter/foundation.dart';

class ModeController extends ChangeNotifier{
  bool isOnline = true;

  void changeMode(bool value){
    isOnline = value;
    notifyListeners();
  }
}