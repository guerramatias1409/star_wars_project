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
              Text("Nombre: ${character.name}", style: TextStyle(fontSize: 25)),
              Text(height == null
                  ? "Altura: unknown"
                  : height > 100
                      ? "Altura: ${height / 100}m"
                      : "Altura: ${height}cm"),
              Text(weight == null ? "Peso: unknown" : "Peso: $weight kg"),
              Text("Sexo: ${character.gender}")
            ],
          ),
        ),
      ),
    );
  }
}
