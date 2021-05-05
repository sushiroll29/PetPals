import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl/constants.dart';
import 'package:fl/screens/home.dart';
import 'package:fl/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:fl/Pet.dart';
import 'package:fl/widgets/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:fl/screens/backgrounds/add_pet_bg.dart';

class NewPetLocationPage extends StatelessWidget {
  final db = Firestore.instance;
  final Pet pet;
  NewPetLocationPage({Key key, @required this.pet}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //TextEditingController _controller = new TextEditingController();
    //_controller.text = pet.location;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height * 0.08,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(1),
          ),
        ),
        backgroundColor: aPrimaryColor,
        centerTitle: true,
        title: Text(
          "ADD A NEW PET",
          style: TextStyle(
            fontFamily:
                GoogleFonts.raleway(fontWeight: FontWeight.w600).fontFamily,
            fontSize: 19,
          ),
        ),
      ),
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Finish"),
            Padding(
              padding: const EdgeInsets.all(30.0),
            ),
            Text("Pet Name ${pet.name}"),
            Text("Pet Gender ${pet.gender}"),
            Text(
                "Pet found on ${DateFormat('dd/MM/yyyy').format(pet.foundOn).toString()}"),
            RoundedButton(
              text: 'FINISH',
              press: () async {
                //save data to firebase
                final uid = await Provider.of(context).auth.getCurrentUID();

                await db
                    .collection("userData")
                    .document(uid)
                    .collection("pets")
                    .add(pet.toJson());

                await db.collection("petsStream").add(pet.toJson());
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            )
          ],
        ),
      ),
    );
  }
}
