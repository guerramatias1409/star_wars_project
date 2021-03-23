import 'package:flutter/foundation.dart';
import 'package:star_wars_project/Models/character.dart';
import 'package:star_wars_project/Models/planet.dart';
import 'package:star_wars_project/Models/starship.dart';
import 'package:star_wars_project/Models/vehicle.dart';

class MyCharacterController extends ChangeNotifier{
  Character selectedCharacter;
  Planet planet;
  List<Vehicle> vehicles = [];
  List<Starship> starships = [];

  MyCharacterController();

  void selectCharacter(Character _character) async {
    vehicles.clear();
    starships.clear();
    selectedCharacter = _character;
    getPlanet();
    getVehicles();
    getStarships();
    notifyListeners();
  }

  void getPlanet() {
    selectedCharacter.planet.then((Planet _planetData) {
      planet = _planetData;
    });
    print("finish get planet");
  }

  void getVehicles() {
    selectedCharacter.vehicles.then((List<Vehicle> _vehicles) {
      _vehicles.forEach((Vehicle _vehicle) {
        vehicles.add(_vehicle);
      });
    });
    print("finish get vehicles");
  }

  void getStarships() {
    selectedCharacter.starships.then((List<Starship> _starships) {
      _starships.forEach((Starship _starship) {
        starships.add(_starship);
      });
    });
    print("finish get starships");
  }
}