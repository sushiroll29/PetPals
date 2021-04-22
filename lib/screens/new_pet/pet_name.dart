import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl/components/text_field_container.dart';
import 'package:fl/constants.dart';
import 'package:fl/screens/backgrounds/add_pet_bg.dart';
import 'package:fl/screens/new_pet/pet_date.dart';
import 'package:fl/screens/new_pet/pet_gender.dart';
import 'package:fl/screens/new_pet/pet_location.dart';
import 'package:fl/widgets/drp.dart';
import 'package:fl/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:fl/Pet.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class NewPetNamePage extends StatelessWidget {
  final Pet pet;
  NewPetNamePage({Key key, @required this.pet}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController _nameController = new TextEditingController();
    TextEditingController _genderController = new TextEditingController();
    _nameController.text = pet.name;
    _genderController.text = pet.gender;

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
                GoogleFonts.raleway(fontWeight: FontWeight.w600).fontFamily,
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

              //CustomDropdown(text: "CHOOSE PET TYPE"),

              AutoSizeText(
                "ENTER THE PET'S NAME",
                maxLines: 1,
                style: TextStyle(
                  fontFamily: GoogleFonts.raleway(fontWeight: FontWeight.w600)
                      .fontFamily,
                  fontSize: 19,
                ),
              ),
              SizedBox(height: size.height * 0.01), //1%
              AutoSizeText(
                "If you don't know it, leave empty.",
                maxLines: 1,
                style: TextStyle(
                  fontFamily: GoogleFonts.raleway(fontWeight: FontWeight.w600)
                      .fontFamily,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: size.height * 0.07), //1%
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFieldContainer(
                  child: TextFormField(
                    textAlign: TextAlign.left,
                    controller: _nameController,
                    autofocus: true,
                    style: TextStyle(
                      fontFamily:
                          GoogleFonts.raleway(fontWeight: FontWeight.normal)
                              .fontFamily,
                      height: 1.3,
                    ),
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                        fontFamily:
                            GoogleFonts.raleway(fontWeight: FontWeight.normal)
                                .fontFamily,
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.all(10.0),
                      icon: Icon(
                        FontAwesomeIcons.paw,
                        size: 15.0,
                        color: aPrimaryColor,
                      ),
                      border: InputBorder.none,
                      hintText: "Pet's name",
                    ),
                  ),
                ),
              ),

              RoundedButton(
                text: 'CONTINUE',
                press: () {
                  pet.name = _nameController.text;
                  pet.gender = _genderController.text;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewPetGenderPage(pet: pet)),
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
