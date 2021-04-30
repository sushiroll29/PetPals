import 'package:fl/constants.dart';
import 'package:fl/pages.dart';
import 'package:fl/screens/detailed_pet.dart';
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

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int selectedItemIndex = 0;
  int selectedBottomItemIndex = -1;

  List<String> bottomMenuItems = [
    'Settings',
    'Log out',
  ];

  List<IconData> bottomMenuIcons = [
    FontAwesomeIcons.cog,
    FontAwesomeIcons.signOutAlt,
  ];

  List<String> menuItems = [
    'Adoption',
    'Add pet',
    'Map',
    'Favorites',
    'Profile',
  ];

  List<IconData> menuIcons = [
    FontAwesomeIcons.paw,
    FontAwesomeIcons.plus,
    FontAwesomeIcons.solidMap,
    FontAwesomeIcons.solidHeart,
    FontAwesomeIcons.userAlt,
  ];

  Widget buildMenuList(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedItemIndex = index;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          children: <Widget>[
            Icon(
              menuIcons[index],
              color: selectedItemIndex == index ? Colors.white : Colors.white38,
              size: 17,
            ),
            SizedBox(width: 15),
            Text(
              menuItems[index],
              style: TextStyle(
                fontSize: 20,
                color:
                    selectedItemIndex == index ? Colors.white : Colors.white38,
                fontFamily: GoogleFonts.quicksand(fontWeight: FontWeight.bold)
                    .fontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomMenuList(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedBottomItemIndex = index;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          children: <Widget>[
            Icon(
              bottomMenuIcons[index],
              color: Colors.white,
              size: 17,
            ),
            SizedBox(width: 15),
            Text(
              bottomMenuItems[index],
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontFamily: GoogleFonts.quicksand(fontWeight: FontWeight.bold)
                    .fontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(
        child: Container(
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 24.0,
                        backgroundColor: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Text(
                          "Ale Surdu",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.bold)
                                .fontFamily,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: menuItems
                        .asMap()
                        .entries
                        .map((e) => buildMenuList(e.key))
                        .toList(),
                  ),
                  Column(
                    children: bottomMenuItems
                        .asMap()
                        .entries
                        .map((e) => buildBottomMenuList(e.key))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [aPrimaryStartingColor, aPrimaryColor],
          )),
        ),
      ),
      //child: SingleChildScrollView(

      /*
      child: StreamBuilder(
          stream: getUsersPets(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text("Loading...");
            return new ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildPetsCard(context, snapshot.data.documents[index]),
            );
          }),*/
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

  Widget buildPetsCard(BuildContext context, DocumentSnapshot document) {
    final pet = Pet.fromSnapshot(document);
    final petType = pet.types();
    return new Container(
        /*
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DetailedPet(pet: pet)));
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 40.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        pet.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily:
                              GoogleFonts.quicksand(fontWeight: FontWeight.w600)
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
                        "Found on ${DateFormat('dd/MM/yyyy').format(pet.foundOn).toString()}",
                        style: TextStyle(
                          fontFamily: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.normal)
                              .fontFamily,
                          height: 1.3,
                        ),
                      ),
                      Spacer(),
                      (petType.containsKey(pet.type))
                          ? petType[pet.type]
                          : petType["dog"],

                      /*
                      Text(
                        Pet.title,
                        style: TextStyle(
                          fontFamily:
                              GoogleFonts.quicksand(fontWeight: FontWeight.normal)
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
      ),*/
        );
  }
}
