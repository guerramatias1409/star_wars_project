import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_project/Models/character.dart';
import 'package:star_wars_project/Models/mode_controller.dart';
import 'package:star_wars_project/Widgets/character_widget.dart';
import 'package:star_wars_project/service.dart';

class FirstScreen extends StatefulWidget {
  FirstScreen({Key key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  Future<List<Character>> _future;

  @override
  void initState() {
    _future = getAllCharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder:
        (BuildContext context, ModeController modeController, Widget child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Star Wars Project"),
          actions: [
            Switch(
                value: modeController.isOnline,
                onChanged: (value) {
                  modeController.changeMode(value);
                }),
          ],
        ),
        body: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView(
                children: _characterList(snapshot.data),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: modeController.isOnline
            ? FloatingActionButton(
                onPressed: () {
                  rebuildList();
                },
                child: Icon(Icons.refresh),
              )
            : Container(),
      );
    });
  }

  List<Widget> _characterList(List<Character> listInfo) {
    List<Widget> list = [];
    listInfo.forEach((character) {
      list.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: CharacterWidget(character: character),
      ));
    });
    return list;
  }

  void rebuildList() {
    setState(() {
      _future = getAllCharacters();
    });
  }
}
