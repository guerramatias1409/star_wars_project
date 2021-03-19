class Character{
  String name;
  num height;
  num weight;
  String gender;
  String hairColor;
  String skinColor;
  String eyeColor;

  Character({this.name, this.height, this.weight, this.gender, this.hairColor, this.skinColor, this.eyeColor});

  @override
  String toString(){
    return 'Name: $name\nHeight: $height\nWeight: $weight\nGender: $gender';
  }

  factory Character.fromJson(Map<String, dynamic> json){
    return Character(
      name: json['name'],
      height: json['height'] == null || json['height'] == 'unknown'? null : num.tryParse(json['height']),
      weight: json['mass'] == null || json['mass'] == 'unknown'? null : num.tryParse(json['mass']),
      gender: json['gender'],
      hairColor: json['hair_color'],
      skinColor: json['skin_color'],
      eyeColor: json['eye_color']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "name": name,
      "height": height,
      "weight": weight,
      "gender": gender,
      "hair_color": hairColor,
      "skin_color": skinColor,
      "eye_color": eyeColor
    };
  }
}