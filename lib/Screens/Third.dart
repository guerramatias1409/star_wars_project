import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_project/Models/character.dart';
import 'package:star_wars_project/Models/my_character_controller.dart';

class Third extends StatefulWidget {
  @override
  _ThirdState createState() => _ThirdState();
}

class _ThirdState extends State<Third> {
  Character character;


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("Assets/fondo3.jpg"))),
          ),
        ],
      ),
    );
  }

  void getCharacter() {
    character = Provider.of<MyCharacterController>(context).selectedCharacter;
  }
}
