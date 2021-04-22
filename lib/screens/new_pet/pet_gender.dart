import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl/components/text_field_container.dart';
import 'package:fl/constants.dart';
import 'package:fl/screens/backgrounds/add_pet_bg.dart';
import 'package:fl/screens/new_pet/pet_date.dart';
import 'package:fl/screens/new_pet/pet_location.dart';
import 'package:fl/widgets/drp.dart';
import 'package:fl/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:fl/Pet.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class NewPetGenderPage extends StatefulWidget {
  final Pet pet;
  NewPetGenderPage({Key key, @required this.pet}) : super(key: key);

  @override
  _NewPetGenderPageState createState() => _NewPetGenderPageState();
}

class _NewPetGenderPageState extends State<NewPetGenderPage> {
  String _currentSelectedValue;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var _genders = ["Male", "Female"];
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
                "ENTER THE PET'S GENDER",
                maxLines: 1,
                style: TextStyle(
                  fontFamily: GoogleFonts.raleway(fontWeight: FontWeight.w600)
                      .fontFamily,
                  fontSize: 19,
                ),
              ),
              SizedBox(height: size.height * 0.01), //1%

              SizedBox(height: size.height * 0.07), //1%

              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                width: size.width * 0.78,
                height: 65,
                child: FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                          fillColor: Colors.red,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(29))),
                      isEmpty: _currentSelectedValue == '',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: new Text("  SELECT PET'S GENDER"),
                          style: TextStyle(
                            fontFamily:
                                GoogleFonts.raleway(fontWeight: FontWeight.w700)
                                    .fontFamily,
                            fontSize: 14,
                            color: aPrimaryColor,
                          ),
                          value: _currentSelectedValue,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _currentSelectedValue = newValue;
                              state.didChange(newValue);
                            });
                          },
                          items: _genders.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),

              RoundedButton(
                text: 'CONTINUE',
                press: () {
                  widget.pet.gender = _currentSelectedValue;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewPetDatePage(pet: widget.pet)),
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
