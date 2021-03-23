import 'package:flutter/foundation.dart';

class DarkModeController extends ChangeNotifier {
  bool isDarkMode = true;

  void changeDarkMode(bool value) {
    isDarkMode = value;
    notifyListeners();
  }
}