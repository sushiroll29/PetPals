import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  //formatting for upload to Firebase
  Map<String, dynamic> toJson() => {
        'type': type,
        'name': name,
        'gender': gender,
        'location': location,
        'age': age,
        'foundOn': foundOn,
        'description': description,
      };

  //create Pet object from Firebase snapshot
  Pet.fromSnapshot(DocumentSnapshot snapshot)
      : type = snapshot['type'],
        name = snapshot['name'],
        gender = snapshot['gender'],
        location = snapshot['location'],
        age = snapshot['age'],
        foundOn = snapshot['foundOn'].toDate(),
        description = snapshot['description'];

  Map<String, Icon> types() => {
        "dog": Icon(FontAwesomeIcons.dog, size: 25),
        "cat": Icon(FontAwesomeIcons.cat, size: 25),
      };

  Map<String, Icon> bigTypes() => {
        "dog": Icon(FontAwesomeIcons.dog, size: 60),
        "cat": Icon(FontAwesomeIcons.cat, size: 60),
      };
}
