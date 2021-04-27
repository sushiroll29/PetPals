import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl/components/announcement_container.dart';
import 'package:fl/components/description_containter.dart';
import 'package:fl/constants.dart';
import 'package:fl/screens/backgrounds/add_pet_bg.dart';
import 'package:fl/screens/new_pet/pet_date.dart';
import 'package:fl/screens/new_pet/pet_gender.dart';
import 'package:fl/screens/new_pet/pet_location.dart';
import 'package:fl/services/auth.dart';
import 'package:fl/widgets/drp.dart';
import 'package:fl/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:fl/Pet.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class NewPetNamePage extends StatefulWidget {
  final Pet pet;
  NewPetNamePage({Key key, @required this.pet}) : super(key: key);

  @override
  _NewPetNamePageState createState() => _NewPetNamePageState();
}

class _NewPetNamePageState extends State<NewPetNamePage> {
  String _currentSelectedGenderValue, _currentSelectedPetValue;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String _name;
    var _genders = ["Male", "Female"];
    var _petTypes = ["Dog", "Cat"];
    //final _nameController = TextEditingController();
    //TextEditingController _genderController = new TextEditingController();
    _nameController.text = widget.pet.name;
    _descriptionController.text = widget.pet.description;
    _ageController.text = widget.pet.age;
    //_genderController.text = widget.pet.gender;

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
            color: Colors.white,
            fontFamily:
                GoogleFonts.quicksand(fontWeight: FontWeight.w600).fontFamily,
            fontSize: 19,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: size.height * 0.03), //1%

            //CustomDropdown(text: "CHOOSE PET TYPE"),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: AutoSizeText(
            //     "ENTER THE PET'S NAME",
            //     maxLines: 1,
            //     textAlign: TextAlign.left,
            //     style: TextStyle(
            //       fontFamily: GoogleFonts.quicksand(fontWeight: FontWeight.w600)
            //           .fontFamily,
            //       fontSize: 19,
            //     ),
            //   ),
            // ),
            SizedBox(height: size.height * 0.01), //1%
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: AutoSizeText(
                    "New pet's details",
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: aPrimaryColor,
                      fontFamily:
                          GoogleFonts.quicksand(fontWeight: FontWeight.w700)
                              .fontFamily,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.03), //1%
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: AutoSizeText(
                    "Pet's name",
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: aPrimaryColor,
                      fontFamily:
                          GoogleFonts.quicksand(fontWeight: FontWeight.w600)
                              .fontFamily,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.005),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: AutoSizeText(
                    "If you don't know it, leave empty.",
                    maxLines: 1,
                    style: TextStyle(
                      color: aPrimaryColor,
                      fontFamily:
                          GoogleFonts.quicksand(fontWeight: FontWeight.w600)
                              .fontFamily,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: size.height * 0.01), //1%

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: TextFieldContainer(
                    child: TextFormField(
                      textAlign: TextAlign.left,
                      controller: _nameController,
                      style: TextStyle(
                        fontFamily:
                            GoogleFonts.quicksand(fontWeight: FontWeight.normal)
                                .fontFamily,
                        height: 1.3,
                      ),
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          fontFamily: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.normal)
                              .fontFamily,
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.all(10.0),
                        icon: Icon(
                          FontAwesomeIcons.paw,
                          size: 16.0,
                          color: aPrimaryColor,
                        ),
                        border: InputBorder.none,
                        hintText: "PET'S NAME",
                        hintStyle: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.01), //1%

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: AutoSizeText(
                    "Type of pet",
                    maxLines: 1,
                    style: TextStyle(
                      color: aPrimaryColor,
                      fontFamily:
                          GoogleFonts.quicksand(fontWeight: FontWeight.w600)
                              .fontFamily,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    width: size.width * 0.978,
                    height: 63,
                    child: FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                              //fillColor: Colors.red,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(29))),
                          isEmpty: _currentSelectedPetValue == '',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: new Text("SELECT PET TYPE"),
                              style: TextStyle(
                                fontFamily: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.w400)
                                    .fontFamily,
                                fontSize: 14,
                                color: aPrimaryColor,
                              ),
                              value: _currentSelectedPetValue,
                              isDense: true,
                              onChanged: (String newValue) {
                                setState(() {
                                  _currentSelectedPetValue = newValue;
                                  state.didChange(newValue);
                                });
                              },
                              items: _petTypes.map((String value) {
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
                ),
              ],
            ),
            SizedBox(height: size.height * 0.01), //1%
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: AutoSizeText(
                    "Pet's gender",
                    maxLines: 1,
                    style: TextStyle(
                      color: aPrimaryColor,
                      fontFamily:
                          GoogleFonts.quicksand(fontWeight: FontWeight.w600)
                              .fontFamily,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    width: size.width * 0.978,
                    height: 63,
                    child: FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                              //fillColor: Colors.red,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(29))),
                          isEmpty: _currentSelectedGenderValue == '',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: new Text("SELECT PET'S GENDER"),
                              style: TextStyle(
                                fontFamily: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.w400)
                                    .fontFamily,
                                fontSize: 14,
                                color: aPrimaryColor,
                              ),
                              value: _currentSelectedGenderValue,
                              isDense: true,
                              onChanged: (String newValue) {
                                setState(() {
                                  _currentSelectedGenderValue = newValue;
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
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: AutoSizeText(
                    "Pet's age",
                    maxLines: 1,
                    style: TextStyle(
                      color: aPrimaryColor,
                      fontFamily:
                          GoogleFonts.quicksand(fontWeight: FontWeight.w600)
                              .fontFamily,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.005),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: AutoSizeText(
                    "Please mention months/years.",
                    maxLines: 1,
                    style: TextStyle(
                      color: aPrimaryColor,
                      fontFamily:
                          GoogleFonts.quicksand(fontWeight: FontWeight.w600)
                              .fontFamily,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.005),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: TextFieldContainer(
                    child: TextFormField(
                      textAlign: TextAlign.left,
                      controller: _ageController,
                      style: TextStyle(
                        fontFamily:
                            GoogleFonts.quicksand(fontWeight: FontWeight.normal)
                                .fontFamily,
                        height: 1.3,
                      ),
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          fontFamily: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.normal)
                              .fontFamily,
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.all(10.0),
                        icon: Icon(
                          FontAwesomeIcons.solidDotCircle,
                          size: 16.0,
                          color: aPrimaryColor,
                        ),
                        border: InputBorder.none,
                        hintText: "PET'S AGE",
                        hintStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.01), //1%
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: AutoSizeText(
                    "Pet's description",
                    maxLines: 1,
                    style: TextStyle(
                      color: aPrimaryColor,
                      fontFamily:
                          GoogleFonts.quicksand(fontWeight: FontWeight.w600)
                              .fontFamily,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.005), //1%
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: DescriptionContainer(
                    child: TextFormField(
                      textAlign: TextAlign.left,
                      controller: _descriptionController,
                      style: TextStyle(
                        fontFamily:
                            GoogleFonts.quicksand(fontWeight: FontWeight.normal)
                                .fontFamily,
                        height: 1.3,
                      ),
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          fontFamily: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.normal)
                              .fontFamily,
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.all(10.0),
                        border: InputBorder.none,
                        hintText: "BRIEFLY DESCRIBE THE PET",
                        hintStyle: TextStyle(fontSize: 14),
                        icon: Icon(
                          FontAwesomeIcons.ellipsisH,
                          size: 16.0,
                          color: aPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            RoundedButton(
              text: 'CONTINUE',
              press: () {
                widget.pet.name = _nameController.text;
                widget.pet.type = _currentSelectedPetValue;
                widget.pet.gender = _currentSelectedGenderValue;
                widget.pet.description = _descriptionController.text;
                widget.pet.age = _ageController.text;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewPetGenderPage(pet: widget.pet)),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
