class Character{
  String name;
  num height;
  num weight;
  String gender;

  Character({this.name, this.height, this.weight, this.gender});

  @override
  String toString(){
    return 'Name: $name\nHeight: $height\nWeight: $weight\nGender: $gender';
  }

  factory Character.fromJson(Map<String, dynamic> json){
    return Character(
      name: json['name'],
      height: json['height'] == null || json['height'] == 'unknown'? null : num.tryParse(json['height']),
      weight: json['mass'] == null || json['mass'] == 'unknown'? null : num.tryParse(json['mass']),
      gender: json['gender']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "name": name,
      "height": height,
      "weight": weight,
      "gender": gender
    };
  }
}