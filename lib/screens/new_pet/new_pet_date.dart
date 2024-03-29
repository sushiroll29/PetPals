import 'package:fl/screens/new_pet/new_pet_phone.dart';
import 'package:fl/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:fl/models/Pet.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl/widgets/constants.dart';

class NewPetDatePage extends StatefulWidget {
  final Pet pet;
  NewPetDatePage({Key key, @required this.pet}) : super(key: key);

  @override
  _NewPetDatePageState createState() => _NewPetDatePageState();
}

class _NewPetDatePageState extends State<NewPetDatePage> {
  bool _isDateValid = false;
  DateTime _foundOn = DateTime.now();
  DateTime _postDate = DateTime.now();

  Future displayDatePick(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        helpText: 'SELECT THE DATE WHEN YOU FOUND THE PET',
        context: context,
        initialDate: _foundOn,
        firstDate: new DateTime(DateTime.now().year - 15),
        //lastDate: DateTime.now().subtract(Duration(days: 1)),
        lastDate: new DateTime(DateTime.now().year + 15),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light().copyWith(
                primary: aPrimaryColor,
              ),
            ),
            child: child,
          );
        });
    if (picked.isAfter(_foundOn)) {
      setState(() {
        _isDateValid = false;
      });
    } else {
      setState(() {
        _isDateValid = true;
      });
    }

    if (picked != null && picked != _foundOn)
      setState(() {
        _foundOn = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Material(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            leading: IconButton(
              color: Colors.grey.shade400,
              icon: Icon(
                FontAwesomeIcons.bars,
                size: 20,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 50),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: Column(
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/images/dog_doodle.png'),
                          height: size.width * 0.75,
                        ),
                        SizedBox(height: 15),
                        RoundedButton(
                            text: 'SELECT DATE',
                            press: () async {
                              await displayDatePick(context);
                              if (_isDateValid == false) {
                                return AlertDialog();
                              }
                            }),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            AutoSizeText(
                              "Found on ${DateFormat('dd MMMM yyyy').format(_foundOn).toString()}.",
                              style: TextStyle(
                                fontFamily: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.w600)
                                    .fontFamily,
                                fontSize: 17,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AutoSizeText(
                              "If this is correct, please continue.",
                              style: TextStyle(
                                fontFamily: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.w600)
                                    .fontFamily,
                                fontSize: 17,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        RoundedButton(
                          text: 'CONTINUE',
                          press: () {
                            //widget.pet.foundOn = _foundOn;
                            widget.pet.postDate = _postDate;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NewPetPhonePage(pet: widget.pet)),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
