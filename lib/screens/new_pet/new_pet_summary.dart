import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:fl/models/Pet.dart';
import 'package:fl/services/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class NewPetSummaryPage extends StatelessWidget {
  final db = Firestore.instance;
  final Pet pet;
  NewPetSummaryPage({Key key, @required this.pet}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Material(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 50),
        child: SingleChildScrollView(
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
                      },
                      child: Icon(FontAwesomeIcons.arrowLeft,
                          color: Colors.grey.shade400)),
                ],
              ),
              Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  child: Column(
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/images/cat_doodle.png'),
                        height: size.width * 0.6,
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "These are your pet's details!\nPlease check if the information is correct.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17.5,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                                fontFamily: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.normal)
                                    .fontFamily,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Name: ${pet.name}",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 17.5,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                                fontFamily: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.normal)
                                    .fontFamily,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Gender: ${pet.gender}",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 17.5,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                                fontFamily: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.normal)
                                    .fontFamily,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Vaccinated: ${pet.isVaccinated}",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 17.5,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                                fontFamily: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.normal)
                                    .fontFamily,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Sterilised: ${pet.isSterilised}",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 17.5,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                                fontFamily: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.normal)
                                    .fontFamily,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Breed: ${pet.breed}",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 17.5,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                                fontFamily: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.normal)
                                    .fontFamily,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Age: ${pet.age}",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 17.5,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                                fontFamily: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.normal)
                                    .fontFamily,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RoundedButton(
                            text: 'FINISH',
                            press: () async {
                              //save data to firebase
                              final uid = await Provider.of(context)
                                  .auth
                                  .getCurrentUID();

                              pet.userId = uid;

                              await db
                                  .collection("userData")
                                  .document(uid)
                                  .collection("pets")
                                  .add(pet.toJson());

                              await db
                                  .collection("petsStream")
                                  //.document(widget.pet.documentId)
                                  .add(pet.toJson());

                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
