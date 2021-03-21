import 'package:connectivity/connectivity.dart';
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
    print("first screen init state");
    checkInitialConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context,
        ModeController connectivityController, Widget child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Star Wars Project"),
          actions: [
            Consumer(builder: (BuildContext context,
                ModeController connectivityController, Widget child) {
              return Switch(
                  value: connectivityController.isOnline,
                  onChanged: (value) async{
                    await connectivityController.changeMode(
                        connectivityBoolean: value);
                    if(connectivityController.isOnline == true){
                      refreshList();
                    }
                  });
            })
          ],
        ),
        body: connectivityController.isOnline == false && _future == null
            ? Center(child: Text("You need connection to get data"))
            : FutureBuilder(
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
        floatingActionButton: connectivityController.isOnline
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

  void rebuildList() async{
    print("Entro a rebuild");
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
     print("No connection, cant refresh");
     Provider.of<ModeController>(context, listen: false)
         .changeMode(connectivityBoolean: false);
    } else {
      refreshList();
    }
  }

  void checkInitialConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    print(connectivityResult);
    if (connectivityResult == ConnectivityResult.none) {
      Provider.of<ModeController>(context, listen: false)
          .changeMode(connectivityBoolean: false);
    } else {
      Provider.of<ModeController>(context, listen: false)
          .changeMode(connectivityBoolean: true);
      refreshList();
    }
  }

  void refreshList(){
    setState(() {
      _future = getAllCharacters();
    });
  }
}
