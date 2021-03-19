import 'package:star_wars_project/Models/Planet.dart';
import 'package:star_wars_project/service.dart';

class Character{
  String name;
  num height;
  num weight;
  String gender;
  String hairColor;
  String skinColor;
  String eyeColor;
  Future<Planet> planet;

  Character({this.name, this.height, this.weight, this.gender, this.hairColor, this.skinColor, this.eyeColor, this.planet});

  @override
  String toString(){
    return 'Name: $name\nHeight: $height\nWeight: $weight\nGender: $gender';
  }

  Character.fromJson(Map<dynamic, dynamic> json){
    this.name = json['name'];
    this.height = json['height'] == null || json['height'] == 'unknown'? null : num.tryParse(json['height']);
    this.weight = json['mass'] == null || json['mass'] == 'unknown'? null : num.tryParse(json['mass']);
    this.gender = json['gender'];
    this.hairColor = json['hair_color'];
    this.skinColor = json['skin_color'];
    this.eyeColor = json['eye_color'];
    this.planet = getPlanet(json['homeworld']);
  }
}