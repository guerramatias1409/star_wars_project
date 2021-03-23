import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_project/Models/character.dart';
import 'package:star_wars_project/constants.dart';
import '../Controllers/dark_mode_controller.dart';
import '../Controllers/my_character_controller.dart';
import 'package:star_wars_project/Models/planet.dart';
import 'package:star_wars_project/Models/starship.dart';
import 'package:star_wars_project/Models/vehicle.dart';

class SecondScreenBodyWidget extends StatefulWidget {

  SecondScreenBodyWidget();

  @override
  _SecondScreenBodyWidgetState createState() => _SecondScreenBodyWidgetState();
}

class _SecondScreenBodyWidgetState extends State<SecondScreenBodyWidget> with TickerProviderStateMixin{
  Character character;
  Planet planet;
  List<Vehicle> vehicles = [];
  List<Starship> starships = [];
  AnimationController controller;
  Animation<int> animation;
  String characterText = "";
  int index = 0;

  @override
  void didChangeDependencies() {
    if (index == 0) {
      controller =
          AnimationController(vsync: this, duration: Duration(seconds: 3));
      getCharacter();
      animation =
          IntTween(begin: 0, end: characterText.length).animate(controller);
      index++;
    }
    super.didChangeDependencies();
  }

  void getCharacter() async {
    character = Provider.of<MyCharacterController>(context).selectedCharacter;
    planet = Provider.of<MyCharacterController>(context).planet;
    vehicles = Provider.of<MyCharacterController>(context).vehicles;
    starships = Provider.of<MyCharacterController>(context).starships;
    setText();
  }

  void setText() {
    characterText = "";
    character.height == null
        ? characterText += "Height: unknown"
        : character.height > 100
        ? characterText += "Height: ${character.height / 100}m"
        : characterText += "Height: ${character.height}cm";
    character.weight == null
        ? characterText += "\nWeight: unknown"
        : characterText += "\nWeight: ${character.weight} kg";
    characterText +=
    "\nGender: ${character.gender}\nHair Color: ${character.hairColor}\nSkin Color: ${character.skinColor}\nEye Color: ${character.eyeColor}\nPlanet: ${planet.name}";

    if (vehicles.length > 0) {
      characterText += "\nVehicles: ";
      vehicles.forEach((vehicle) {
        characterText += "\n\t- ${vehicle.name}";
      });
    }
    if (starships.length > 0) {
      characterText += "\nStarships: ";
      starships.forEach((starship) {
        characterText += "\n\t- ${starship.name}";
      });
    }
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, DarkModeController darkModeController, Widget child){
        return darkModeController.isDarkMode ?
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 8, right: 8, top: 15),
            child: Card(
              color: Colors.white.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  Text(
                    character.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  planet == null
                      ? Expanded(
                    child: Container(
                      width: 300,
                      child: Center(
                          child: Text(
                            COULDNT_LOAD_TRY_AGAIN.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          )),
                    ),
                  )
                      : Flexible(
                    child: SingleChildScrollView(
                      child: AnimatedBuilder(
                        animation: animation,
                        builder: (BuildContext context,
                            Widget child) {
                          return Container(
                            width: double.infinity,
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(
                                  horizontal: 16),
                              child: Text(
                                characterText.substring(
                                    0, animation.value),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  decoration:
                                  TextDecoration.none,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ) :
        Expanded(
          child: Column(
            children: [
              Text(
                character.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
              planet == null ?
              Expanded(
                child: Container(
                  width: 300,
                  child: Center(
                      child: Text(
                        COULDNT_LOAD_TRY_AGAIN.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        )
                        ,
                      )                  ),
                ),
              ) : Flexible(
                child: SingleChildScrollView(
                  child: AnimatedBuilder(
                    animation: animation,
                    builder: (BuildContext context, Widget child) {
                      return Container(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16),
                          child: Text(
                            characterText.substring(0, animation.value),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
