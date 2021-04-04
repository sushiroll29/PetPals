import 'package:fl/screens/new_pet/pet_location.dart';
import 'package:fl/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:fl/Pet.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'dart:async';
import 'package:intl/intl.dart';

class NewPetDatePage extends StatefulWidget {
  final Pet pet;
  NewPetDatePage({Key key, @required this.pet}) : super(key: key);

  @override
  _NewPetDatePageState createState() => _NewPetDatePageState();
}

class _NewPetDatePageState extends State<NewPetDatePage> {
  DateTime _foundOn = DateTime.now();

  Future displayDatePick(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _foundOn,
        firstDate: new DateTime(DateTime.now().year - 5),
        lastDate: new DateTime(DateTime.now().year + 5));

    if (picked != null && picked != _foundOn)
      setState(() {
        _foundOn = picked;
      });
  }

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
            Text("Pet Name ${widget.pet.name}"),
            Text("Enter a date"),
            RoundedButton(
                text: 'SELECT DATE',
                press: () async {
                  await displayDatePick(context);
                }),
            Padding(
              padding: const EdgeInsets.all(30.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                    "Found on: ${DateFormat('dd/MM/yyyy').format(_foundOn).toString()}")
              ],
            ),
            RoundedButton(
              text: 'CONTINUE',
              press: () {
                widget.pet.foundOn = _foundOn;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          NewPetLocationPage(pet: widget.pet)),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
