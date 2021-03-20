import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_project/Models/MyCharacter.dart';
import 'package:star_wars_project/Models/character.dart';
import 'package:star_wars_project/Screens/second_screen.dart';

class CharacterWidget extends StatelessWidget {
  final Character character;

  CharacterWidget({this.character});
  @override
  Widget build(BuildContext context) {
    num height = character.height;
    num weight = character.weight;
    return GestureDetector(
      onTap: () {
        selectAndGoToSecondScreen(context);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Text("Name: ${character.name}", style: TextStyle(fontSize: 25)),
              Text(height == null
                  ? "Height: unknown"
                  : height > 100
                      ? "Height: ${height / 100}m"
                      : "Height: ${height}cm"),
              Text(weight == null ? "Weight: unknown" : "Weight: $weight kg"),
              Text("Gender: ${character.gender}")
            ],
          ),
        ),
      ),
    );
  }

  void selectAndGoToSecondScreen(BuildContext _context) {
    Provider.of<MyCharacterController>(_context, listen: false).selectCharacter(character);
    Navigator.push(_context, MaterialPageRoute(builder: (context) => SecondScreen()));
  }
}
