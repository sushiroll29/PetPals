import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl/Pet.dart';
import 'package:fl/components/description_containter.dart';
import 'package:fl/constants.dart';
import 'package:fl/trash/my_pets_trash.dart';
import 'package:fl/screens/my_pets_updated.dart';
import 'package:fl/widgets/provider.dart';
import 'package:fl/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MyPetsDetailed extends StatefulWidget {
  final Pet pet;

  MyPetsDetailed({Key key, @required this.pet}) : super(key: key);

  @override
  _MyPetsDetailedState createState() => _MyPetsDetailedState();
}

class _MyPetsDetailedState extends State<MyPetsDetailed> {
  var _description, _vaccinated, _sterilised, _specialCare, _microchipped;
  String _isV;
  List isVaccinated = ["Yes", "No", "Don't know"];
  final db = Firestore.instance;

  TextEditingController _descriptionController = TextEditingController();
  bool isPressed = false;

  void initState() {
    super.initState();
    _descriptionController.text = widget.pet.description.toString();
    _description = widget.pet.description;
    _vaccinated = widget.pet.isVaccinated;
    _sterilised = widget.pet.isSterilised;
    _specialCare = widget.pet.requiresSpecialCare;
    _microchipped = widget.pet.hasMicrochip;
  }

  List<String> petDetails = [
    'Vaccinated: ',
    'Sterilised: ',
    'Microchipped: ',
    'Requires special care: '
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
                    padding:
                        const EdgeInsets.only(right: 8.0, left: 8.0, top: 55),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(FontAwesomeIcons.arrowLeft),
                                color: aPrimaryLightColor,
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                            IconButton(
                                icon: Icon(FontAwesomeIcons.ellipsisH),
                                color: aPrimaryLightColor,
                                onPressed: () {
                                  //print(widget.pet.documentId);
                                  _petEditModalBottomSheet(context);
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
                                      'Description',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
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
                        'Found on ${DateFormat('dd/MM/yyyy').format(widget.pet.foundOn).toString()}',
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

  _petEditModalBottomSheet(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(25.0),
          topRight: const Radius.circular(25.0),
        )),
        isDismissible: false,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Container(
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.only(
                //     topLeft: const Radius.circular(25.0),
                //     topRight: const Radius.circular(25.0),
                //   ),
                // ),
                height: MediaQuery.of(context).size.height * 0.9,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                widget.pet.name,
                                style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 18.5,
                                  fontFamily: GoogleFonts.quicksand(
                                          fontWeight: FontWeight.bold)
                                      .fontFamily,
                                ),
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(FontAwesomeIcons.timesCircle,
                                  color: Colors.grey.shade800, size: 20),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(bottom: 10.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       Text(
                      //         widget.pet.name,
                      //         style: TextStyle(
                      //           color: Colors.grey.shade800,
                      //           fontSize: 18.5,
                      //           fontFamily: GoogleFonts.quicksand(
                      //                   fontWeight: FontWeight.bold)
                      //               .fontFamily,
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      Row(
                        children: [
                          Expanded(
                              child: DescriptionContainer(
                            child: GestureDetector(
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                              },
                              child: TextField(
                                style: TextStyle(
                                    fontFamily: GoogleFonts.quicksand(
                                            fontWeight: FontWeight.w600)
                                        .fontFamily,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey.shade600),
                                autocorrect: false,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                textAlign: TextAlign.left,
                                controller: _descriptionController,
                                decoration: InputDecoration(
                                  hintText: 'Description',
                                  hintStyle: TextStyle(
                                      fontFamily: GoogleFonts.quicksand(
                                              fontWeight: FontWeight.w600)
                                          .fontFamily,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey.shade400),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ))
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Is the pet vaccinated?",
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontFamily: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.w600)
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: <Widget>[
                          addVaccinatedRadioButton(0, 'Yes'),
                          addVaccinatedRadioButton(1, 'No'),
                          addVaccinatedRadioButton(2, "Don't know"),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Is the pet sterilised?",
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontFamily: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.w600)
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: <Widget>[
                          addSterilisedRadioButton(0, 'Yes'),
                          addSterilisedRadioButton(1, 'No'),
                          addSterilisedRadioButton(2, "Don't know"),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Is the pet microchipped?",
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontFamily: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.w600)
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: <Widget>[
                          addMicrochipRadioButton(0, 'Yes'),
                          addMicrochipRadioButton(1, 'No'),
                          addMicrochipRadioButton(2, "Don't know"),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Does the pet require special care?",
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontFamily: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.w600)
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: <Widget>[
                          addSpecialCareRadioButton(0, 'Yes'),
                          addSpecialCareRadioButton(1, 'No'),
                          addSpecialCareRadioButton(2, "Don't know"),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RoundedButton(
                              text: 'Save',
                              press: () async {
                                widget.pet.isVaccinated = _vaccinated;
                                widget.pet.description =
                                    _descriptionController.text;
                                widget.pet.isSterilised = _sterilised;
                                widget.pet.hasMicrochip = _microchipped;
                                setState(() {
                                  _vaccinated = widget.pet.isVaccinated;
                                  _description = widget.pet.description;
                                  _sterilised = widget.pet.isSterilised;
                                  _microchipped = widget.pet.hasMicrochip;
                                });
                                await updatePet(context);
                                await updateMyPet(context);
                                Navigator.of(context).pop();
                              })
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RoundedButton(
                              color: Colors.red.shade400,
                              text: 'Delete pet',
                              press: () async {
                                await deleteMyPet(context);
                                print("sters my pet");
                                await deletePet(context);
                                print("sters pet");
                                //Navigator.of(context).pus
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MyPetsUpdatedPage()));
                              })
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Row addVaccinatedRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: aPrimaryColor,
          value: isVaccinated[btnValue],
          groupValue: _vaccinated,
          onChanged: (value) {
            setState(() {
              _vaccinated = value;
            });
          },
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontFamily:
                GoogleFonts.quicksand(fontWeight: FontWeight.w600).fontFamily,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Row addSterilisedRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: aPrimaryColor,
          value: isVaccinated[btnValue],
          groupValue: _sterilised,
          onChanged: (value) {
            setState(() {
              _sterilised = value;
            });
          },
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontFamily:
                GoogleFonts.quicksand(fontWeight: FontWeight.w600).fontFamily,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Row addSpecialCareRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: aPrimaryColor,
          value: isVaccinated[btnValue],
          groupValue: _specialCare,
          onChanged: (value) {
            setState(() {
              _specialCare = value;
            });
          },
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontFamily:
                GoogleFonts.quicksand(fontWeight: FontWeight.w600).fontFamily,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Row addMicrochipRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: aPrimaryColor,
          value: isVaccinated[btnValue],
          groupValue: _microchipped,
          onChanged: (value) {
            setState(() {
              _microchipped = value;
            });
          },
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontFamily:
                GoogleFonts.quicksand(fontWeight: FontWeight.w600).fontFamily,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget showImageDialog(_width, _height) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        elevation: 20,
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

  Future updateMyPet(context) async {
    var uuid = await Provider.of(context).auth.getCurrentUID();
    final doc = Firestore.instance
        .collection('userData')
        .document(uuid)
        .collection('pets')
        .document(widget.pet.documentId);

    return await doc.setData(widget.pet.toJson());
  }

  Future updatePet(context) async {
    var uuid = await Provider.of(context).auth.getCurrentUID();
    final doc = Firestore.instance
        .collection('petsStream')
        .document(widget.pet.documentId);

    return await doc.setData(widget.pet.toJson());
  }

  Future deletePet(context) async {
    final doc = Firestore.instance
        .collection('petsStream')
        .document(widget.pet.documentId);

    return await doc.delete();
  }

  Future deleteMyPet(context) async {
    var uuid = await Provider.of(context).auth.getCurrentUID();

    final doc = Firestore.instance
        .collection('userData')
        .document(uuid)
        .collection('pets')
        .document(widget.pet.documentId);
    print(widget.pet.documentId);
    print(uuid);
    return await doc.delete();
  }
}
