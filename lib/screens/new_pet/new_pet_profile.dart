import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl/components/announcement_container.dart';
import 'package:fl/components/description_containter.dart';
import 'package:fl/constants.dart';
import 'package:fl/screens/new_pet/new_pet_location.dart';
import 'package:fl/widgets/provider.dart';
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
  String _currentSelectedGenderValue,
      _currentSelectedVaccinatedValue,
      _currentSelectedSterilisedValue,
      _currentSelectedSpecialCareValue,
      _usersName;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ageController = TextEditingController();
  final _breedController = TextEditingController();
  List genders = ["Male", "Female"];
  List requiresSpecialCare = ["Yes", "No"];
  List isVaccinated = ["Yes", "No", "Don't know"];
  List isSterilised = ["Yes", "No", "Don't know"];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _nameController.text = widget.pet.name;
    _descriptionController.text = widget.pet.description;
    _ageController.text = widget.pet.age;

    return Material(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Padding(
          padding: EdgeInsets.only(
            top: 50,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(FontAwesomeIcons.arrowLeft,
                                color: Colors.grey.shade400)),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: AutoSizeText(
                          "New pet's details",
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontFamily: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.w700)
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
                  SizedBox(height: size.height * 0.01),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: TextFieldContainer(
                          child: TextFormField(
                            autocorrect: false,
                            textAlign: TextAlign.left,
                            controller: _nameController,
                            style: TextStyle(
                              fontFamily: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.normal)
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
                              hintText: "e.g. Bobby",
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey.shade400),
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
                          "Pet's gender",
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

                  Row(
                    children: <Widget>[
                      addGenderRadioButton(0, 'Male'),
                      addGenderRadioButton(1, 'Female'),
                    ],
                  ),

                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: AutoSizeText(
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
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: AutoSizeText(
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
                  Row(
                    children: <Widget>[
                      addSterilisedRadioButton(0, 'Yes'),
                      addSterilisedRadioButton(1, 'No'),
                      addSterilisedRadioButton(2, "Don't know"),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: AutoSizeText(
                          "Pet's breed",
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
                  SizedBox(height: size.height * 0.005),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: AutoSizeText(
                          "If you don't know it, write down 'Mix'.",
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
                  SizedBox(height: size.height * 0.005),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: TextFieldContainer(
                          child: TextFormField(
                            autocorrect: false,
                            textAlign: TextAlign.left,
                            controller: _breedController,
                            style: TextStyle(
                              fontFamily: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.normal)
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
                              hintText: "e.g. Pitbull",
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey.shade400),
                            ),
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
                  SizedBox(height: size.height * 0.005),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: AutoSizeText(
                          "Please mention months/years.",
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
                  SizedBox(height: size.height * 0.005),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: TextFieldContainer(
                          child: TextFormField(
                            autocorrect: false,
                            textAlign: TextAlign.left,
                            controller: _ageController,
                            style: TextStyle(
                              fontFamily: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.normal)
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
                              // icon: Icon(
                              //   FontAwesomeIcons.solidDotCircle,
                              //   size: 16.0,
                              //   color: Colors.grey.shade700,
                              // ),
                              border: InputBorder.none,
                              hintText: "e.g. 5 years",
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey.shade400),
                            ),
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
                  Row(
                    children: <Widget>[
                      addSpecialCareRadioButton(0, 'Yes'),
                      addSpecialCareRadioButton(1, 'No'),
                    ],
                  ),

                  SizedBox(height: size.height * 0.01), //1%
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: AutoSizeText(
                          "Pet's description\nPlease mention any special needs.",
                          maxLines: 4,
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
                  SizedBox(height: size.height * 0.005), //1%
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: DescriptionContainer(
                          child: TextFormField(
                            autocorrect: false,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            textAlign: TextAlign.left,
                            controller: _descriptionController,
                            style: TextStyle(
                              fontFamily: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.normal)
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
                              contentPadding:
                                  EdgeInsets.only(top: 10, bottom: 10),
                              border: InputBorder.none,
                              hintText: "Brief description of the pet",
                              hintStyle: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade400),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  FutureBuilder(
                    future: Provider.of(context).auth.getCurrentUser(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return getUserInformation(context, snapshot);
                      } else {
                        return Container(
                          height: 0,
                        );
                      }
                    },
                  ),

                  RoundedButton(
                    text: 'CONTINUE',
                    press: () {
                      widget.pet.usersName = _usersName;
                      widget.pet.name = _nameController.text;
                      widget.pet.breed = _breedController.text;
                      widget.pet.gender = _currentSelectedGenderValue;
                      widget.pet.isVaccinated = _currentSelectedVaccinatedValue;
                      widget.pet.isSterilised = _currentSelectedSterilisedValue;
                      widget.pet.requiresSpecialCare =
                          _currentSelectedSpecialCareValue;
                      widget.pet.description = _descriptionController.text;
                      widget.pet.age = _ageController.text;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MapScreen(pet: widget.pet)),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row addGenderRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: aPrimaryColor,
          value: genders[btnValue],
          groupValue: _currentSelectedGenderValue,
          onChanged: (value) {
            setState(() {
              _currentSelectedGenderValue = value;
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

  Row addVaccinatedRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: aPrimaryColor,
          value: isVaccinated[btnValue],
          groupValue: _currentSelectedVaccinatedValue,
          onChanged: (value) {
            setState(() {
              _currentSelectedVaccinatedValue = value;
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
          value: requiresSpecialCare[btnValue],
          groupValue: _currentSelectedSpecialCareValue,
          onChanged: (value) {
            setState(() {
              _currentSelectedSpecialCareValue = value;
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
          value: isSterilised[btnValue],
          groupValue: _currentSelectedSterilisedValue,
          onChanged: (value) {
            setState(() {
              _currentSelectedSterilisedValue = value;
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

  Widget getUserInformation(context, snapshot) {
    final authData = snapshot.data;
    _usersName = authData.displayName;
    return Container(height: 0);
  }
}
