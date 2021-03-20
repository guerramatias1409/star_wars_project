import 'package:flutter/foundation.dart';
import 'package:star_wars_project/Models/character.dart';

class MyCharacterController extends ChangeNotifier{
  Character selectedCharacter;

  MyCharacterController();

  void selectCharacter(Character _character){
    selectedCharacter = _character;
    notifyListeners();
  }
}