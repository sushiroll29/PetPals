import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String phoneNumber;

  User(this.phoneNumber);

  //formatting for upload to Firebase
  Map<String, dynamic> toJson() => {
        'phoneNumber': phoneNumber,
      };

  User.fromSnapshot(DocumentSnapshot snapshot)
      : phoneNumber = snapshot['phoneNumber'];
}
