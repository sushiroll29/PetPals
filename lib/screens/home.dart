import 'package:fl/constants.dart';
import 'package:fl/pages.dart';
import 'package:fl/services/auth.dart';
import 'package:fl/widgets/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl/Pet.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Pet> PetsList = [
    Pet("Dog", "Bernie", "M", "Timisoara", "5", DateTime.now()),
    Pet("Cat", "Tom", "F", "Mosnita", "?", DateTime.now()),
    Pet("Parrot", "Coco", "F", "Dumbravita", "10", DateTime.now()),
    Pet("Hamster", "Laurentiu", "M", "Timisoara", "?", DateTime.now())
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      //child: SingleChildScrollView(
      child: new ListView.builder(
        itemCount: PetsList.length,
        itemBuilder: (BuildContext context, int index) =>
            buildPetsCard(context, index),
      ),
    );
    //);
  }

  Widget buildPetsCard(BuildContext context, int index) {
    final Pet = PetsList[index];
    return new Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 40.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      Pet.name,
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily:
                            GoogleFonts.manjari(fontWeight: FontWeight.bold)
                                .fontFamily,
                        height: 1.3,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Age: ${Pet.age}",
                      style: TextStyle(
                        fontFamily:
                            GoogleFonts.manjari(fontWeight: FontWeight.normal)
                                .fontFamily,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      Pet.location,
                      style: TextStyle(
                        fontFamily:
                            GoogleFonts.manjari(fontWeight: FontWeight.normal)
                                .fontFamily,
                        height: 1.3,
                      ),
                    ),
                    Spacer(),
                    Text(
                      Pet.sex,
                      style: TextStyle(
                        fontFamily:
                            GoogleFonts.manjari(fontWeight: FontWeight.normal)
                                .fontFamily,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Found on ${DateFormat('dd/MM/yyyy').format(Pet.found).toString()}",
                      style: TextStyle(
                        fontFamily:
                            GoogleFonts.manjari(fontWeight: FontWeight.normal)
                                .fontFamily,
                        height: 1.3,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      FontAwesomeIcons.dog,
                    )
                    /*
                    Text(
                      Pet.title,
                      style: TextStyle(
                        fontFamily:
                            GoogleFonts.manjari(fontWeight: FontWeight.normal)
                                .fontFamily,
                        height: 1.3,
                      ),
                    ),*/
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
