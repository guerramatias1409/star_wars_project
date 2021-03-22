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
  /*String planet;
  List<String> vehicles = [];
  List<String> starships = [];*/

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
    /*setState(() {
      planet = character.planet;
    });*/
    selectedCharacter.planet.then((Planet _planetData) {
      planet = _planetData;
    });
    print("finish get planet");
  }

  void getVehicles() {
    /*character.vehicles.forEach((element) {
      vehicles.add(element);
    });*/
    selectedCharacter.vehicles.then((List<Vehicle> _vehicles) {
      _vehicles.forEach((Vehicle _vehicle) {
        vehicles.add(_vehicle);
      });
    });
    print("finish get vehicles");
  }

  void getStarships() {
    /*character.starships.forEach((element) {
      starships.add(element);
    });*/

    selectedCharacter.starships.then((List<Starship> _starships) {
      _starships.forEach((Starship _starship) {
        starships.add(_starship);
      });
    });
    print("finish get starships");
  }
}