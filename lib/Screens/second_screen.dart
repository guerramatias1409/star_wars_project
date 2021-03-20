import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_project/Models/MyCharacter.dart';
import 'package:star_wars_project/Models/planet.dart';
import 'package:star_wars_project/Models/starship.dart';
import 'package:star_wars_project/Models/vehicle.dart';
import 'package:star_wars_project/Models/character.dart';
import 'package:star_wars_project/service.dart';

class SecondScreen extends StatefulWidget {

  SecondScreen();

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  /* Planet planet;
  List<Vehicle> vehicles = [];
  List<Starship> starships = [];*/
  String planet;
  List<String> vehicles = [];
  List<String> starships = [];
  Character character;

  @override
  void didChangeDependencies() {
    getCharacter();
    super.didChangeDependencies();
  }

  void getCharacter() async{
    character = Provider.of<MyCharacterController>(context).selectedCharacter;
    getPlanet();
    getVehicles();
    getStarships();
  }

  void getPlanet() {
    setState(() {
      planet = character.planet;
    });
    /*widget.character.planet.then((Planet _planetData) {
      setState(() {
        planet = _planetData;
      });
    });*/
  }

  void getVehicles() {
    character.vehicles.forEach((element) {
      vehicles.add(element);
    });
    /*widget.character.vehicles.then((List<Vehicle> _vehicles) {
      _vehicles.forEach((Vehicle _vehicle) {
          vehicles.add(_vehicle);
      });
    });*/
  }

  void getStarships() {
    character.starships.forEach((element) {
      starships.add(element);
    });

    /*widget.character.starships.then((List<Starship> _starships) {
      _starships.forEach((Starship _starship) {
        starships.add(_starship);
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return character == null ? Container() : Scaffold(
      appBar: AppBar(
        title: Text("Star Wars Project"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Name: ${character.name}",
                  style: TextStyle(fontSize: 25)),
              Text(character.height == null
                  ? "Height: unknown"
                  : character.height > 100
                      ? "Height: ${character.height / 100}m"
                      : "Height: ${character.height}cm"),
              Text(character.weight == null
                  ? "Weight: unknown"
                  : "Weight: ${character.weight} kg"),
              Text("Gender: ${character.gender}"),
              Text("Hair Color: ${character.hairColor}"),
              Text("Skin Color: ${character.skinColor}"),
              Text("Eye Color: ${character.eyeColor}"),
              planet == null ? Container() : Text("Planet: ${planet/*planet.name*/}"),
              vehicles == null || vehicles.length < 1
                  ? Container()
                  : Flexible(
                      child: ListView(
                        children: _vehiclesWidget(),
                      ),
                    ),
              starships == null || starships.length < 1
                  ? Container()
                  : Flexible(
                      child: ListView(
                        children: _starshipsWidget(),
                      ),
                    ),
              Expanded(
                child: SizedBox(),
              ),
              FloatingActionButton.extended(
                  onPressed: () {
                    sendPost(character);
                  },
                  label: Text("Reportar"))
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _vehiclesWidget() {
    List<Widget> list = [Text("Vehicles:")];
    vehicles.forEach((vehicle) {
      list.add(Text(vehicle/*vehicle.name*/));
    });
    return list;
  }

  List<Widget> _starshipsWidget() {
    List<Widget> list = [Text("Starships:")];
    starships.forEach((starship) {
      list.add(Text(starship/*starship.name*/));
    });
    return list;
  }
}
