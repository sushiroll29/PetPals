import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl/models/Pet.dart';
import 'package:fl/widgets/constants.dart';
import 'package:fl/services/provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailedPet extends StatefulWidget {
  final Pet pet;

  DetailedPet({Key key, @required this.pet}) : super(key: key);

  @override
  _DetailedPetState createState() => _DetailedPetState();
}

class _DetailedPetState extends State<DetailedPet> {
  Future<void> _launched;
  final db = Firestore.instance;
  bool isPressed = false;
  List<String> petDetails = [
    'Vaccinated: ',
    'Sterilised: ',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment(0, -0.25),
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topCenter,
                    height: size.height * 0.4,
                    child: GestureDetector(
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (_) =>
                                showImageDialog(size.width, size.height * 0.6));
                      },
                      child: Image.network(
                        "${widget.pet.imageURL}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 55),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: <Widget>[
                            IconButton(
                                icon: Icon(FontAwesomeIcons.arrowLeft),
                                color: aPrimaryLightColor,
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 90),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            height: 50,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Wrap(
                                      spacing: 3,
                                      runSpacing: 3,
                                      children: [
                                        Container(
                                          height: 30,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: aPrimaryLightColor,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Text(
                                            'Vaccinated: ${widget.pet.isVaccinated}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey.shade600,
                                              fontFamily: GoogleFonts.quicksand(
                                                      fontWeight:
                                                          FontWeight.normal)
                                                  .fontFamily,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 30,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: aPrimaryLightColor,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Text(
                                            'Sterilised: ${widget.pet.isSterilised}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey.shade600,
                                              fontFamily: GoogleFonts.quicksand(
                                                      fontWeight:
                                                          FontWeight.normal)
                                                  .fontFamily,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 30,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: aPrimaryLightColor,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Text(
                                            'Has microchip: ${widget.pet.hasMicrochip}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey.shade600,
                                              fontFamily: GoogleFonts.quicksand(
                                                      fontWeight:
                                                          FontWeight.normal)
                                                  .fontFamily,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 30,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: aPrimaryLightColor,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Text(
                                            'Requires special care: ${widget.pet.requiresSpecialCare}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey.shade600,
                                              fontFamily: GoogleFonts.quicksand(
                                                      fontWeight:
                                                          FontWeight.normal)
                                                  .fontFamily,
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '${widget.pet.usersName}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade600,
                                        fontFamily: GoogleFonts.quicksand(
                                                fontWeight: FontWeight.normal)
                                            .fontFamily,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${DateFormat('dd MMMM yyyy').format(widget.pet.postDate).toString()}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade600,
                                    fontFamily: GoogleFonts.quicksand(
                                            fontWeight: FontWeight.normal)
                                        .fontFamily,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            '${widget.pet.description}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                              fontFamily: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.normal)
                                  .fontFamily,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 130,
                decoration: BoxDecoration(
                  color: aLightGreyColor.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Material(
                        borderRadius: BorderRadius.circular(25),
                        elevation: 4,
                        color: aPrimaryColor,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.solidHeart,
                              color: (isPressed) ? Colors.red : Colors.white,
                            ),
                            onPressed: () async {
                              //saves to Favorites collection in Firebase
                              if (isPressed == false) {
                                final uid = await Provider.of(context)
                                    .auth
                                    .getCurrentUID();

                                await db
                                    .collection("userData")
                                    .document(uid)
                                    .collection("favorites")
                                    .add(widget.pet.toJson());

                                setState(() {
                                  isPressed = true;
                                });
                              }

                              // if (isPressed == true) {
                              //   await deletePet(context);
                              // }
                              /*
                                final uid = await Provider.of(context)
                                    .auth
                                    .getCurrentUID();

                                await db
                                    .collection("userData")
                                    .document(uid)
                                    .collection("favorites")
                                    .add(widget.pet.toJson());
                                    */
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Material(
                          borderRadius: BorderRadius.circular(25),
                          elevation: 4,
                          color: aPrimaryColor,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: FlatButton(
                              child: Text(
                                'Adopt me',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: GoogleFonts.quicksand(
                                          fontWeight: FontWeight.w700)
                                      .fontFamily,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  _launched = _makePhoneCall(
                                      'tel:${widget.pet.userPhoneNumber}');
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                height: 125,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 15,
                    bottom: 15,
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.pet.name,
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 18.5,
                              fontFamily: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.bold)
                                  .fontFamily,
                            ),
                          ),
                          Icon(
                              widget.pet.gender == 'Male'
                                  ? FontAwesomeIcons.mars
                                  : FontAwesomeIcons.venus,
                              color: Colors.grey.shade400),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.pet.breed}',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontFamily: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.w600)
                                  .fontFamily,
                            ),
                          ),
                          Text(
                            '${widget.pet.age} old',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontFamily: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.w600)
                                  .fontFamily,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Found on ${DateFormat('dd MMMM yyyy').format(widget.pet.foundOn).toString()}',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontFamily:
                              GoogleFonts.quicksand(fontWeight: FontWeight.w600)
                                  .fontFamily,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

//   Future deleteFromFav(context) async {
//     var uuid = await Provider.of(context).auth.getCurrentUID();
//     final doc = Firestore.instance
//         .collection('userData')
//         .document(uuid)
//         .collection('favorites')
//         .document();

//     return await doc.delete();
//   }
// }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget showImageDialog(_width, _height) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(8),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            width: _width,
            height: _height,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage("${widget.pet.imageURL}"),
              fit: BoxFit.fitWidth,
            )),
          ),
        ),
      ),
    );
  }
}
