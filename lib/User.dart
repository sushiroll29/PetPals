class User {
  String phoneNumber;

  User(this.phoneNumber);

  //formatting for upload to Firebase
  Map<String, dynamic> toJson() => {
        'phoneNumber': phoneNumber,
      };
}
