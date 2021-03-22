import 'package:fl/screens/new_pet/pet_date.dart';
import 'package:fl/screens/new_pet/pet_location.dart';
import 'package:fl/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:fl/Pet.dart';

class NewPetNamePage extends StatelessWidget {
  final Pet pet;
  NewPetNamePage({Key key, @required this.pet}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController _nameController = new TextEditingController();
    _nameController.text = pet.name;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new pet - Name'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Enter a name"),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _nameController,
                autofocus: true,
              ),
            ),
            RoundedButton(
              text: 'CONTINUE',
              press: () {
                pet.name = _nameController.text;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewPetDatePage(pet: pet)),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
