import 'package:flutter/material.dart';
import 'package:star_wars_project/Models/character.dart';

class SecondScreen extends StatefulWidget {
  Character character;

  SecondScreen({this.character});

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
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
            children: [
              Text("Nombre: ${widget.character.name}", style: TextStyle(fontSize: 25)),
              Text(widget.character.height == null
                  ? "Altura: unknown"
                  : widget.character.height > 100
                  ? "Altura: ${widget.character.height / 100}m"
                  : "Altura: ${widget.character.height}cm"),
              Text(widget.character.weight == null ? "Peso: unknown" : "Peso: ${widget.character.weight} kg"),
              Text("Sexo: ${widget.character.gender}")
            ],
          ),
        ),
      ),
    );
  }
}
