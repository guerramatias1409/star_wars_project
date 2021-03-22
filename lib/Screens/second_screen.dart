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

class SecondScreen extends StatefulWidget {
  SecondScreen();

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> with SingleTickerProviderStateMixin<SecondScreen>{
  Character character;
  Planet planet;
  List<Vehicle> vehicles = [];
  List<Starship> starships = [];
  String characterText = "";
  bool isReady = false;
  AnimationController controller;
  Animation<int> animation;
  int index = 0;
  ImageProvider background = AssetImage("Assets/fondo3.jpg");

  @override
  void didChangeDependencies() {
    if(index==0){
      controller = AnimationController(vsync: this, duration: Duration(seconds: 3));
      getCharacter();
      animation = IntTween(begin: 0, end: characterText.length).animate(controller);
      index++;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: background)),
          ),
          character == null
              ? Container()
              : Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                child: AnimatedBuilder(
                  animation: animation,
                  builder: (BuildContext context, Widget child){
                    return Text(characterText.substring(0, animation.value), style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      decoration: TextDecoration.none,
                    ),);
                  },
                )
              /*AnimatedDefaultTextStyle(
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
                      )*/
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
}
