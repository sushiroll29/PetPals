import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:fl/Pet.dart';

class NewPetLocationPage extends StatelessWidget {
  final db = Firestore.instance;
  final Pet pet;
  NewPetLocationPage({Key key, @required this.pet}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController _controller = new TextEditingController();
    _controller.text = pet.location;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new pet - Location'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Finish"),
            Padding(
              padding: const EdgeInsets.all(30.0),
            ),
            Text("Pet Name ${pet.name}"),
            Text("Pet found on ${pet.found}"),
            RoundedButton(
              text: 'FINISH',
              press: () async {
                //save data to firebase
                await db.collection("pets").add({
                  'name': pet.name,
                  'found on': pet.found,
                });

                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            )
          ],
        ),
      ),
    );
  }
}
