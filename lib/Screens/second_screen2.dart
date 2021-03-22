import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_project/Models/mode_controller.dart';
import 'package:star_wars_project/Models/my_character_controller.dart';
import 'package:star_wars_project/Models/planet.dart';
import 'package:star_wars_project/Models/starship.dart';
import 'package:star_wars_project/Models/vehicle.dart';
import 'package:star_wars_project/Models/character.dart';
import 'package:star_wars_project/service.dart';

class SecondScreen2 extends StatefulWidget {
  SecondScreen2();

  @override
  _SecondScreen2State createState() => _SecondScreen2State();
}

class _SecondScreen2State extends State<SecondScreen2> {
  Character character;
  Planet planet;
  List<Vehicle> vehicles = [];
  List<Starship> starships = [];
  String characterText = "";
  bool isReady = false;

  @override
  void didChangeDependencies() {
    getCharacter();
    super.didChangeDependencies();
  }

  void getCharacter() async {
    character = Provider.of<MyCharacterController>(context).selectedCharacter;
    planet = Provider.of<MyCharacterController>(context).planet;
    vehicles = Provider.of<MyCharacterController>(context).vehicles;
    starships = Provider.of<MyCharacterController>(context).starships;
    setText();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: character == null
          ? Container()
          : Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        "Assets/fondo3.jpg"))),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
              child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 3000),
                    style: isReady ?
                    TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      decoration: TextDecoration.none,
                      letterSpacing: 0,
                    ) :
                    TextStyle(
                      color: Colors.transparent,
                      fontSize: 25,
                      decoration: TextDecoration.none,
                      letterSpacing: 0,
                    ),
                    child: Text(
                        characterText
                    )


                    /*Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(character.name,
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
                            planet == null
                                ? Container()
                                : Text("Planet: ${*//*planet*//* planet.name}"),
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
                          ],
                        )*/,
                  )
              ),
            ),
          ),
          Consumer(
            builder: (BuildContext _context,
                ModeController modeController, Widget child) {
              return modeController.isOnline
                  ? Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: FloatingActionButton.extended(
                    onPressed: () {
                      checkAndSendPost();
                    },
                    label: Text("Reportar")),
              )
                  : Container();
            },
          )

        ],
      ),
    );
  }

  List<Widget> _vehiclesWidget() {
    List<Widget> list = [Text("Vehicles:")];
    vehicles.forEach((vehicle) {
      list.add(Text(/*vehicle*/ vehicle.name));
    });
    return list;
  }

  List<Widget> _starshipsWidget() {
    List<Widget> list = [Text("Starships:")];
    starships.forEach((starship) {
      list.add(Text(/*starship*/ starship.name));
    });
    return list;
  }

  void checkAndSendPost() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      print("No connection, cant refresh");
      Provider.of<ModeController>(context, listen: false)
          .changeMode(connectivityBoolean: false);
    } else {
      sendPost(character);
    }
  }

  void setText() {
    character.height == null
        ? characterText+="Height: unknown"
        : character.height > 100
        ? characterText+="Height: ${character.height / 100}m"
        : characterText+="Height: ${character.height}cm";
    character.weight == null
        ? characterText+="\nWeight: unknown"
        : characterText+="\nWeight: ${character.weight} kg";
    characterText+="\nGender: ${character.gender}\nHair Color: ${character.hairColor}\nSkin Color: ${character.skinColor}\nEye Color: ${character.eyeColor}\nPlanet: ${planet.name}";

    if(vehicles.length>1){
      characterText+="\nVehicles: ";
      vehicles.forEach((vehicle) {
        characterText+="\n\t- ${vehicle.name}";
      });
    }
    if(starships.length>1){
      characterText+="\nStarships: ";
      starships.forEach((starship) {
        characterText+="\n\t- ${starship.name}";
      });
    }
    print("CHARACTER TEXT: $characterText");
    Timer(Duration(seconds: 3), (){
      setState(() {
        isReady = true;
      });
    });
    print("IS READY $isReady");
  }
}
