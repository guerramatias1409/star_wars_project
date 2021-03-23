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

class SecondScreen extends StatefulWidget {
  SecondScreen();

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen>
    with SingleTickerProviderStateMixin<SecondScreen> {
  Character character;
  Planet planet;
  List<Vehicle> vehicles = [];
  List<Starship> starships = [];
  String characterText = "";
  AnimationController controller;
  Animation<int> animation;
  int index = 0;
  ImageProvider background = AssetImage("Assets/fondo3.jpg");
  bool sendingPost = false;
  bool postSent = false;

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
    var appBar = AppBar();
    return Material(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(fit: BoxFit.cover, image: background)),
          ),
          character == null
              ? Container()
              : Column(
            children: [
              SizedBox(height: 30),
              Container(
                width: double.infinity,
                height: appBar.preferredSize.height-10,
                child: IconButton(
                  padding: const EdgeInsets.all(12.0),
                  alignment: Alignment.centerLeft,
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  iconSize: 34,
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
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
                        "Couldn't load data. Please try again...".toUpperCase(),
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
              ),
              SizedBox(height: 85)
            ],
          ) ,
          Align(
            alignment: Alignment.bottomCenter,
            child: Consumer(
              builder: (BuildContext _context, ModeController modeController,
                  Widget child) {
                return modeController.isOnline
                    ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedCrossFade(
                    crossFadeState: !postSent ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                    duration: Duration(seconds: 1),
                    firstChild: Container(
                      height: 60,
                      width: 300,
                      child: FloatingActionButton.extended(
                          backgroundColor: Colors.black,
                          shape: Border.all(color: Color(0xFFFFE444), width: 4),
                          onPressed: () {
                            if(!sendingPost){
                              setState(() {
                                sendingPost = true;
                              });
                              checkAndSendPost();
                            }
                          },
                          label: Text("Report", style: TextStyle(
                              color: Color(0xFFFFE444),
                              fontSize: 20
                          ),)),
                    ),
                    secondChild: Container(
                      height: 60,
                      width: 300,
                      child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(color: Color(0xFFFFE444), width: 4),
                              shape: BoxShape.circle
                          ),
                          child: Icon(Icons.check, color: Color(0xFFFFE444),size: 45)),
                    ),
                  ),
                )
                    : Container();
              },
            ),
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
      sendPost(character).then((result) {
        if(result==1){
          Timer(Duration(seconds: 1), (){
            setState(() {
              postSent = true;
            });
          });
        }
      });
    }
  }
}
