import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

class Pet {
  String type;
  String name;
  String breed;
  String gender;
  String isVaccinated;
  PickResult location;
  String age;
  DateTime foundOn;
  DateTime postDate;
  String description;

  Pet(this.type, this.name, this.breed, this.gender, this.isVaccinated,
      this.location, this.age, this.foundOn, this.postDate, this.description);

  //formatting for upload to Firebase
  Map<String, dynamic> toJson() => {
        'type': type,
        'name': name,
        'breed': breed,
        'gender': gender,
        'isVaccinated': isVaccinated,
        'location': location,
        'age': age,
        'foundOn': foundOn,
        'postDate': postDate,
        'description': description,
      };

  //create Pet object from Firebase snapshot
  Pet.fromSnapshot(DocumentSnapshot snapshot)
      : type = snapshot['type'],
        name = snapshot['name'],
        breed = snapshot['breed'],
        gender = snapshot['gender'],
        isVaccinated = snapshot['isVaccinated'],
        location = snapshot['location'],
        age = snapshot['age'],
        foundOn = snapshot['foundOn'].toDate(),
        postDate = snapshot['postDate'].toDate(),
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
