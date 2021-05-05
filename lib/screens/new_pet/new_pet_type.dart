import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl/constants.dart';
import 'package:fl/screens/new_pet/new_pet_image.dart';
import 'package:fl/screens/new_pet/new_pet_profile.dart';
import 'package:fl/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:fl/Pet.dart';
import 'package:fl/widgets/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:fl/screens/backgrounds/add_pet_bg.dart';

class NewPetTypePage extends StatefulWidget {
  final Pet pet;

  NewPetTypePage({Key key, @required this.pet}) : super(key: key);

  @override
  _NewPetTypePageState createState() => _NewPetTypePageState();
}

class _NewPetTypePageState extends State<NewPetTypePage> {
  @override
  Widget build(BuildContext context) {
    final petTypes = widget.pet.bigTypes();
    var petKeys = petTypes.keys.toList();

    Size size = MediaQuery.of(context).size;
    //TextEditingController _controller = new TextEditingController();
    //_controller.text = pet.location;

    return Material(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      //widget.onMenuTap();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => MenuPage()
                      // ),
                    },
                    child: Icon(FontAwesomeIcons.arrowLeft,
                        color: Colors.grey.shade400)),
              ],
            ),
            SizedBox(height: size.height * 0.25),
            AutoSizeText(
              "Please choose the pet type",
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontFamily: GoogleFonts.quicksand(fontWeight: FontWeight.w700)
                    .fontFamily,
                fontSize: 20,
              ),
            ),
            Expanded(
                child: GridView.count(
              crossAxisCount: 2,
              scrollDirection: Axis.vertical,
              primary: false,
              children: List.generate(petTypes.length, (index) {
                return FlatButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      petTypes[petKeys[index]],
                      //Text(petKeys[index]),
                    ],
                  ),
                  onPressed: () async {
                    widget.pet.type = petKeys[index];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NewPetNamePage(pet: widget.pet)),
                    );
                  },
                );
              }),
            )),
          ],
        ),
      ),
    );
  }
}
