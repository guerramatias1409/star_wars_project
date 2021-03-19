import 'package:http/http.dart' as http;
import 'package:star_wars_project/Models/character.dart';
import 'dart:convert';

Future<List<Character>> getAllCharacters() async {
  String charactersUrl = 'https://swapi.dev/api/people/';
  List<Character> characters = [];
  var response = await http.get(Uri.parse(charactersUrl));
  var jsonData = json.decode(response.body);
  var list = jsonData['results'] as List;
  list.forEach((element) async {
    characters.add(Character.fromJson(element));
  });
  while(jsonData['next'] != "" && jsonData['next'] != null){
    String next = jsonData['next'];
    response = await http.get(Uri.parse(next.replaceAll('http:', 'https:')));
    jsonData = json.decode(response.body);
    list = jsonData['results'] as List;
    list.forEach((element) async {
      characters.add(Character.fromJson(element));
    });
  }
  print("LENGHT: ${characters.length}");
  return characters;
}
