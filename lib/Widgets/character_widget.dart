import 'package:flutter/material.dart';
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
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondScreen(character: character)));
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
              Text("Sex: ${character.gender}")
            ],
          ),
        ),
      ),
    );
  }
}
