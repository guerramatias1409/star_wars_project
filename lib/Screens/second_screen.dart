import 'package:flutter/material.dart';
import 'package:star_wars_project/Models/character.dart';
import 'package:star_wars_project/service.dart';

class SecondScreen extends StatefulWidget {
  final Character character;

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
}
