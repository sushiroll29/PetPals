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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl/widgets/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      //child: SingleChildScrollView(
      child: StreamBuilder(
          stream: getUsersPets(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text("Loading...");
            return new ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildPetsCard(context, snapshot.data.documents[index]),
            );
          }),
    );
    //);
  }

  Stream<QuerySnapshot> getUsersPets(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance
        .collection("petsStream")
        //.document()
        //.collection("pets")
        .orderBy('foundOn')
        .snapshots();
  }

  Widget buildPetsCard(BuildContext context, DocumentSnapshot pet) {
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
                      pet['name'],
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily:
                            GoogleFonts.raleway(fontWeight: FontWeight.w600)
                                .fontFamily,
                        height: 1.3,
                      ),
                    ),
                    Spacer(),
                    // Text(
                    //   "Age: ${pet['age']}",
                    //   style: TextStyle(
                    //     fontFamily:
                    //         GoogleFonts.manjari(fontWeight: FontWeight.normal)
                    //             .fontFamily,
                    //     height: 1.3,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(
                  children: <Widget>[
                    // Text(
                    //   pet['location'],
                    //   style: TextStyle(
                    //     fontFamily:
                    //         GoogleFonts.manjari(fontWeight: FontWeight.normal)
                    //             .fontFamily,
                    //     height: 1.3,
                    //   ),
                    // ),
                    // Spacer(),
                    // Text(
                    //   pet['gender'],
                    //   style: TextStyle(
                    //     fontFamily:
                    //         GoogleFonts.manjari(fontWeight: FontWeight.normal)
                    //             .fontFamily,
                    //     height: 1.3,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Found on ${DateFormat('dd/MM/yyyy').format(pet['foundOn'].toDate()).toString()}",
                      style: TextStyle(
                        fontFamily:
                            GoogleFonts.raleway(fontWeight: FontWeight.normal)
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
                            GoogleFonts.raleway(fontWeight: FontWeight.normal)
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
