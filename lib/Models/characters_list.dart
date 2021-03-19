import 'package:star_wars_project/Models/character.dart';

class CharactersList{
  List<Character> characterList;

  CharactersList({this.characterList});

  factory CharactersList.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<Character> characters = [];
    list.forEach((element) async{
      characters.add(Character.fromJson(element));
    });
    return CharactersList(characterList: characters);
  }
}