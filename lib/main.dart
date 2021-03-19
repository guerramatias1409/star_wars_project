import 'package:flutter/material.dart';
import 'package:star_wars_project/Models/character.dart';
import 'package:star_wars_project/Widgets/character_widget.dart';
import 'package:star_wars_project/service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Star Wars App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text("Star Wars Project"),
      ),
      body: FutureBuilder(
        future: getAllCharacters(),
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
    );
  }
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
