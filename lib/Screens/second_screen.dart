import 'package:flutter/material.dart';
import 'package:star_wars_project/Models/Planet.dart';
import 'package:star_wars_project/Models/Vehicle.dart';
import 'package:star_wars_project/Models/character.dart';
import 'package:star_wars_project/service.dart';

class SecondScreen extends StatefulWidget {
  final Character character;

  SecondScreen({this.character});

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  Planet planet;
  List<Vehicle> vehicles = [];

  @override
  void initState() {
    getPlanet();
    getVehicles();
    super.initState();
  }

  void getPlanet() {
    widget.character.planet.then((Planet _planetData) {
      setState(() {
        planet = _planetData;
      });
    });
  }

  void getVehicles() {
    widget.character.vehicles.then((List<Vehicle> _vehicles) {
      _vehicles.forEach((Vehicle _vehicle) {
          vehicles.add(_vehicle);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Text("Name: ${widget.character.name}",
                  style: TextStyle(fontSize: 25)),
              Text(widget.character.height == null
                  ? "Height: unknown"
                  : widget.character.height > 100
                      ? "Height: ${widget.character.height / 100}m"
                      : "Height: ${widget.character.height}cm"),
              Text(widget.character.weight == null
                  ? "Weight: unknown"
                  : "Weight: ${widget.character.weight} kg"),
              Text("Gender: ${widget.character.gender}"),
              Text("Hair Color: ${widget.character.hairColor}"),
              Text("Skin Color: ${widget.character.skinColor}"),
              Text("Eye Color: ${widget.character.eyeColor}"),
              planet == null ? Container() : Text("Planet: ${planet.name}"),
              vehicles == null || vehicles.length < 1  ? Container() :
                Flexible(
                  child: ListView(
                    children: _vehiclesWidget(),
                  ),
                ),
              Expanded(
                child: SizedBox(),
              ),
              FloatingActionButton.extended(
                  onPressed: () {
                    sendPost(widget.character);
                  },
                  label: Text("Reportar"))
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _vehiclesWidget() {
    List<Widget> list = [
      Text("Vehicles:")
    ];
    vehicles.forEach((vehicle) {
      list.add(Text(vehicle.name));
    });
    return list;
  }
}


