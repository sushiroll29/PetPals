import 'package:fl/screens/new_pet/pet_location.dart';
import 'package:fl/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:fl/Pet.dart';

class NewPetDatePage extends StatelessWidget {
  final Pet pet;
  NewPetDatePage({Key key, @required this.pet}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new pet - Date'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Pet Name ${pet.name}"),
            Text("Enter a date"),
            Padding(
              padding: const EdgeInsets.all(30.0),
            ),
            RoundedButton(
              text: 'CONTINUE',
              press: () {
                pet.foundOn = DateTime.now();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewPetLocationPage(pet: pet)),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
