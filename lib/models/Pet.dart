import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Pet {
  String type;
  String name;
  String breed;
  String gender;
  String isVaccinated;
  String isSterilised;
  GeoPoint location;
  String age;
  DateTime foundOn;
  DateTime postDate;
  String description;
  String documentId;
  String userId;
  String userPhoneNumber;
  String usersName;
  String requiresSpecialCare;
  String imageURL;
  String hasMicrochip;
  //bool isFavorite;

  Pet(
      this.type,
      this.name,
      this.breed,
      this.gender,
      this.isVaccinated,
      this.isSterilised,
      this.location,
      this.age,
      this.foundOn,
      this.postDate,
      this.userId,
      this.description,
      this.userPhoneNumber,
      this.usersName,
      this.requiresSpecialCare,
      this.hasMicrochip,
      this.imageURL);
  //this.documentId,
  //this.isFavorite);

  //formatting for upload to Firebase
  Map<String, dynamic> toJson() => {
        'type': type,
        'name': name,
        'breed': breed,
        'gender': gender,
        'isVaccinated': isVaccinated,
        'isSterilised': isSterilised,
        'location': location,
        'age': age,
        'foundOn': foundOn,
        'postDate': postDate,
        'description': description,
        'documentId': documentId,
        'userId': userId,
        'userPhoneNumber': userPhoneNumber,
        'usersName': usersName,
        'requiresSpecialCare': requiresSpecialCare,
        'imageURL': imageURL,
        'hasMicrochip': hasMicrochip,
        //'isFavorite': isFavorite,
      };

  //create Pet object from Firebase snapshot
  Pet.fromSnapshot(DocumentSnapshot snapshot)
      : type = snapshot['type'],
        name = snapshot['name'],
        breed = snapshot['breed'],
        gender = snapshot['gender'],
        isVaccinated = snapshot['isVaccinated'],
        isSterilised = snapshot['isSterilised'],
        location = snapshot['location'],
        age = snapshot['age'],
        foundOn = snapshot['foundOn'].toDate(),
        postDate = snapshot['postDate'].toDate(),
        description = snapshot['description'],
        userId = snapshot['userId'],
        documentId = snapshot.documentID,
        userPhoneNumber = snapshot['userPhoneNumber'],
        usersName = snapshot['usersName'],
        requiresSpecialCare = snapshot['requiresSpecialCare'],
        imageURL = snapshot['imageURL'],
        hasMicrochip = snapshot['hasMicrochip'];
  //userId = snapshot['userId'],
  //isFavorite = snapshot['isFavorite'];
  //userId = ;

  Map<String, Icon> types() => {
        "dog":
            Icon(FontAwesomeIcons.dog, size: 25, color: Colors.grey.shade500),
        "cat":
            Icon(FontAwesomeIcons.cat, size: 25, color: Colors.grey.shade500),
      };

  Map<String, Icon> bigTypes() => {
        "dog":
            Icon(FontAwesomeIcons.dog, size: 60, color: Colors.grey.shade800),
        "cat":
            Icon(FontAwesomeIcons.cat, size: 60, color: Colors.grey.shade800),
      };
}
