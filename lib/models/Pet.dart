import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl/widgets/constants.dart';
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
  String favoritesId;
  String petSize;
  String street;
  String city;
  String country;
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
      this.favoritesId,
      this.petSize,
      this.imageURL,
      this.street,
      this.city,
      this.country);
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
        'favoritesId': favoritesId,
        'petSize': petSize,
        'street': street,
        'city': city,
        'country': country,
        //'isFavorite': isFavorite,
      };

  //create Pet object from Firebase snapshot
  Pet.fromSnapshot(DocumentSnapshot snapshot)
      : type = snapshot['type'],
        name = snapshot['name'],
        breed = snapshot['breed'],
        gender = snapshot['gender'],
        petSize = snapshot['petSize'],
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
        hasMicrochip = snapshot['hasMicrochip'],
        favoritesId = snapshot['favoritesId'],
        street = snapshot['street'],
        city = snapshot['city'],
        country = snapshot['country'];
  //userId = snapshot['userId'],
  //isFavorite = snapshot['isFavorite'];
  //userId = ;

  Map<String, Icon> types() => {
        "dog":
            Icon(FontAwesomeIcons.dog, size: 25, color: Colors.grey.shade500),
        "cat":
            Icon(FontAwesomeIcons.cat, size: 25, color: Colors.grey.shade500),
      };

  Map<String, Widget> bigTypes() => {
        "dog": Image.asset(
          "assets/icons/dog_icon.png",
          height: 50,
          width: 50,
        ),
        "cat": Image.asset(
          "assets/icons/cat_icon.png",
          height: 50,
          width: 50,
        ),
        "parrot": Image.asset(
          "assets/icons/parrot_icon.png",
          height: 50,
          width: 50,
        ),
        "guinea pig": Image.asset(
          "assets/icons/guinea_icon.png",
          height: 50,
          width: 50,
        ),
        "hamster": Image.asset(
          "assets/icons/hamster_icon.png",
          height: 50,
          width: 50,
        ),
        "rabbit": Image.asset(
          "assets/icons/rabbit_icon.png",
          height: 50,
          width: 50,
        ),
        "fish": Image.asset(
          "assets/icons/fish_icon.png",
          height: 50,
          width: 50,
        ),
        "snake": Image.asset(
          "assets/icons/snake_icon.png",
          height: 50,
          width: 50,
        ),
      };
}
