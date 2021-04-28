import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

class Pet {
  String type;
  String name;
  String gender;
  PickResult location;
  String age;
  DateTime foundOn;
  String description;

  Pet(this.type, this.name, this.gender, this.location, this.age, this.foundOn,
      this.description);

  Map<String, dynamic> toJson() => {
        'type': type,
        'name': name,
        'gender': gender,
        'location': location,
        'age': age,
        'foundOn': foundOn,
        'description': description,
      };
}
