class Character{
  String name;
  String height;
  String weight;
  String gender;

  Character({this.name, this.height, this.weight, this.gender});

  @override
  String toString(){
    return 'Name: $name\nHeight: $height\nWeight: $weight\nGender: $gender';
  }

  factory Character.fromJson(Map<String, dynamic> json){
    return Character(
      name: json['name'],
      height: json['height'],
      weight: json['mass'],
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