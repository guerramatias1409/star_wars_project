import 'package:flutter/material.dart';
import 'package:star_wars_project/Models/character.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Star Wars Project"),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return ListView(
              children: _characterList(snapshot.data),
            );
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          rebuildList();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  List<Widget> _characterList(List<Character> listInfo){
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
