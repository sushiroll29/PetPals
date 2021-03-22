class Pet {
  String type;
  String name;
  String gender;
  String location;
  String age;
  DateTime foundOn;

  Pet(this.type, this.name, this.gender, this.location, this.age, this.foundOn);

  Map<String, dynamic> toJson() => {
        'type': type,
        'name': name,
        'gender': gender,
        'location': location,
        'age': age,
        'foundOn': foundOn,
      };
}
