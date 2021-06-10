import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:fl/models/Pet.dart';
import 'package:fl/services/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_fonts/google_fonts.dart';

class NewPetSummaryPage extends StatefulWidget {
  final Pet pet;
  NewPetSummaryPage({Key key, @required this.pet}) : super(key: key);

  @override
  _NewPetSummaryPageState createState() => _NewPetSummaryPageState();
}

class _NewPetSummaryPageState extends State<NewPetSummaryPage> {
  var _longitude, _latitude;
  List<Address> results = [];
  bool isLoading = false;
  String petStreet, petCity, petCountry;
  final db = Firestore.instance;

  @override
  void initState() {
    super.initState();
    _longitude = widget.pet.location.longitude;
    _latitude = widget.pet.location.latitude;
    getAddressFromCoords(_latitude, _longitude);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Material(
      child: Padding(
        padding: EdgeInsets.only(left: 22.0, right: 22, top: 50, bottom: 20),
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
                      child: Icon(
                        FontAwesomeIcons.arrowLeft,
                        color: Colors.grey.shade400,
                        size: 20,
                      )),
                  Center(
                    child: Text(
                      "Summary",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                        color: Colors.grey.shade500,
                        fontFamily:
                            GoogleFonts.quicksand(fontWeight: FontWeight.normal)
                                .fontFamily,
                      ),
                    ),
                  ),
                  Text("aa", style: TextStyle(color: Colors.white)),
                ],
              ),
              Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // Expanded(
                          //   child: Text(
                          //     "Please check if the information you have provided is correct.",
                          //     textAlign: TextAlign.center,
                          //     style: TextStyle(
                          //       fontSize: 17.5,
                          //       fontWeight: FontWeight.w600,
                          //       color: Colors.grey.shade600,
                          //       fontFamily: GoogleFonts.quicksand(
                          //               fontWeight: FontWeight.normal)
                          //           .fontFamily,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(height: 25),
                      Image(
                        image: NetworkImage(widget.pet.imageURL),
                        //image: AssetImage('assets/images/cat_doodle.png'),
                        height: size.width * 0.6,
                      ),
                      SizedBox(height: 60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Name: ${widget.pet.name}",
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
                              "Age: ${widget.pet.age}",
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
                              "Gender: ${widget.pet.gender}",
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
                              "Breed: ${widget.pet.breed}",
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
                              "Size category: ${widget.pet.petSize}",
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
                              "Vaccinated: ${widget.pet.isVaccinated}",
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
                              "Sterilised: ${widget.pet.isSterilised}",
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
                              "Microchipped: ${widget.pet.hasMicrochip}",
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

                              widget.pet.userId = uid;
                              widget.pet.street = petStreet;
                              widget.pet.city = petCity;
                              widget.pet.country = petCountry;

                              await db
                                  .collection("userData")
                                  .document(uid)
                                  .collection("pets")
                                  .add(widget.pet.toJson());

                              await db
                                  .collection("petsStream")
                                  //.document(widget.pet.documentId)
                                  .add(widget.pet.toJson());

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

  Future getAddressFromCoords(_lat, _long) async {
    this.setState(() {
      this.isLoading = true;
    });

    try {
      //var longitude, latitude;
      var results = await Geocoder.local
          .findAddressesFromCoordinates(new Coordinates(_lat, _long));
      this.setState(() {
        this.results = results;
      });
    } catch (e) {
      print("Error occured: $e");
    } finally {
      this.setState(() {
        this.isLoading = false;
        petStreet = "${results[0].thoroughfare}";
        petCity = "${results[0].locality}";
        petCountry = "${results[0].countryName}";
      });
    }
  }
}
