import 'package:fl/screens/backgrounds/add_pet_bg.dart';
import 'package:fl/screens/new_pet/new_pet_summary.dart';
import 'package:fl/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:fl/Pet.dart';
//import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl/constants.dart';

class NewPetDatePage extends StatefulWidget {
  final Pet pet;
  NewPetDatePage({Key key, @required this.pet}) : super(key: key);

  @override
  _NewPetDatePageState createState() => _NewPetDatePageState();
}

class _NewPetDatePageState extends State<NewPetDatePage> {
  DateTime _foundOn = DateTime.now();
  DateTime _postDate = DateTime.now();

  Future displayDatePick(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        helpText: 'SELECT THE DATE WHEN YOU FOUND THE PET',
        context: context,
        initialDate: _foundOn,
        firstDate: new DateTime(DateTime.now().year - 5),
        lastDate: new DateTime(DateTime.now().year + 5),
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

    if (picked != null && picked != _foundOn)
      setState(() {
        _foundOn = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                GoogleFonts.quicksand(fontWeight: FontWeight.w600).fontFamily,
            fontSize: 19,
          ),
        ),
      ),
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.03), //1%
              //1%
              AutoSizeText(
                'WHEN DID YOU FIND THE PET?',
                maxLines: 1,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: GoogleFonts.quicksand(fontWeight: FontWeight.w700)
                      .fontFamily,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: size.height * 0.003), //1%
              AutoSizeText(
                'Provide the most accurate date you can remember.',
                maxLines: 1,
                style: TextStyle(
                  fontFamily: GoogleFonts.quicksand(fontWeight: FontWeight.w600)
                      .fontFamily,
                  fontSize: 17,
                ),
              ),
              SizedBox(height: size.height * 0.02), //1%
              // AutoSizeText(
              //   "Pet name: ${widget.pet.name}",
              //   maxLines: 1,
              //   style: TextStyle(
              //     fontFamily: GoogleFonts.quicksand(fontWeight: FontWeight.w600)
              //         .fontFamily,
              //     fontSize: 19,
              //   ),
              // ),
              // SizedBox(height: size.height * 0.03), //1%
              // AutoSizeText(
              //   "Enter a date",
              //   style: TextStyle(
              //     fontFamily: GoogleFonts.quicksand(fontWeight: FontWeight.w600)
              //         .fontFamily,
              //     fontSize: 19,
              //   ),
              // ),
              SizedBox(height: size.height * 0.01), //1%
              RoundedButton(
                  text: 'SELECT DATE',
                  press: () async {
                    await displayDatePick(context);
                  }),
              Padding(
                padding: const EdgeInsets.all(30.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  AutoSizeText(
                    "Found on: ${DateFormat('dd/MM/yyyy').format(_foundOn).toString()}",
                    style: TextStyle(
                      fontFamily:
                          GoogleFonts.quicksand(fontWeight: FontWeight.w600)
                              .fontFamily,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.004), //1%
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AutoSizeText(
                    "Is this correct?",
                    style: TextStyle(
                      fontFamily:
                          GoogleFonts.quicksand(fontWeight: FontWeight.w600)
                              .fontFamily,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.1), //1%
              RoundedButton(
                text: 'CONTINUE',
                press: () {
                  widget.pet.foundOn = _foundOn;
                  widget.pet.postDate = _postDate;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NewPetLocationPage(pet: widget.pet)),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
